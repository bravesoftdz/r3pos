unit ufrmCheckOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons, cxTextEdit,
  cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList,
  Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit, cxCalendar, zBase,
  RzButton, ZAbstractRODataset, ZAbstractDataset, ZDataset,Math;

type
  TfrmCheckOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    Label9: TLabel;
    edtCHK_USER_TEXT: TcxTextEdit;
    edtPropertyAMOUNT: TBCDField;
    edtPropertyCALC_AMOUNT: TBCDField;
    edtREMARK: TcxTextEdit;
    edtCREA_USER: TzrComboBoxList;
    edtCREA_DATE: TcxDateEdit;
    actImportFromPrint: TAction;
    actImportFromMac: TAction;
    N2: TMenuItem;
    RzBitBtn1: TRzBitBtn;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Lbl_LinkCheckGood: TLabel;
    LblCount: TLabel;
    LblMm: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject; var Handled: Boolean);
    procedure edtCREA_USERSaveValue(Sender: TObject);
    procedure actImportFromPrintExecute(Sender: TObject);
    procedure edtCREA_USERAddClick(Sender: TObject);
    procedure edtSHOP_IDSaveValue(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure Lbl_LinkCheckGoodMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Lbl_LinkCheckGoodMouseLeave(Sender: TObject);
    procedure edtTableAfterDelete(DataSet: TDataSet);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject; var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure Lbl_LinkCheckGoodClick(Sender: TObject);
  private
    { Private declarations }
    w:integer;
    PrintQry: TZQuery;
    FIsCalcRecordCount: Boolean; //启用盘点时创建的库存明细且没有录入盘点数量
    procedure CalcRecordCount;   //计算记录
    procedure SetRecordCount(ReSum: Integer);    //
    procedure GetPrintQryData(TENANT_ID,SHOP_ID,PRINT_ID: string; IsQry: Boolean=False);
    procedure Calc(Kind: integer);
    procedure SetIsCalcRecordCount(const Value: Boolean); //Kind(1)1:输入 实盘 计算 盈亏; (2)2:输入 盈亏 计算 实盘
    procedure UnitToCalc(UNIT_ID:string);override;
    procedure AmountToCalc(Amount:Real);override;
    function  CheckRepeat(AObj:TRecord_;var pt:boolean):boolean;override;
    function  GetCalcUnitValue(GODS_ID: string): Real; //2011.04.02 Add单位换算关系
    procedure RefreshRckAMount(CalcValue: real=0); //2011.04.02 Add 刷新账面库存
  public
    //检测数据合法性
    procedure CheckInvaid;override;
    function CheckInput:boolean;override;
    //输入批号
    function GodsToBatchNo(id:string):boolean;override;
    procedure AddRecord(AObj:TRecord_;UNIT_ID:string;Located:boolean=false;IsPresent:boolean=false);override;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure Open(id:string);override;
    property  IsCalcRecordCount: Boolean read FIsCalcRecordCount write SetIsCalcRecordCount;
  end;

  //calc_
  
implementation

uses
  uGlobal,uShopUtil,uXDictFactory,uExpression,uFnUtil,uDsUtil,
  uShopGlobal,ufrmCheckTask,ufrmGoodsInfo,ufrmUsersInfo, ufrmCheckAudit,
  ufrmSelectCheckGoods;


 {$R *.dfm}

procedure TfrmCheckOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmCheckOrder.DeleteOrder;
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
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TPrintOrder',nil);
    Factor.AddBatch(cdsDetail,'TPrintData',nil);
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  AObj.ReadFromDataSet(cdsHeader);
  ReadFromObject(AObj,self);
  ReadFrom(cdsDetail);
  //读取计算PrintQry；
  GetPrintQryData(InttoStr(Global.TENANT_ID),Global.SHOP_ID,inttoStr(AObj.fieldbyName('PRINT_DATE').AsInteger)) ;
  if (PrintQry.Active) and (edtTable.Active) then
  begin
    IsCalcRecordCount:=true;
    SetRecordCount(PrintQry.RecordCount-edtTable.RecordCount); 
    Lbl_LinkCheckGoodMouseLeave(nil);
  end;
  //判断审核：
  IsAudit :=(AObj.FieldbyName('CHECK_STATUS').AsInteger=3);
  //oid := AObj.FieldbyName('PRINT_DATE').asString;
  gid := InttoStr(AObj.FieldbyName('PRINT_DATE').AsInteger);    //盘点单号
  cid := AObj.FieldbyName('SHOP_ID').asString;
  dbState := dsBrowse;
end;

procedure TfrmCheckOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
  if edtCREA_DATE.CanFocus then edtCREA_DATE.SetFocus;
end;

procedure TfrmCheckOrder.FormCreate(Sender: TObject);
begin
  inherited;
  isZero := true;
  gRepeat := false;  //判断允许重复
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  dbState := dsBrowse;
  edtCREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');

  self.RzPanel3.Enabled:=true;
  edtCHK_DATE.Enabled:=False;
  edtCHK_USER_TEXT.Enabled:=false;
  PrintQry:=TZQuery.Create(self); //启用盘点时创建的库存明细且没有录入盘点数量
  IsCalcRecordCount:=False;
end;

procedure TfrmCheckOrder.NewOrder;
var
  rs:TZQuery;
begin
  inherited;
  Open(FormatDatetime('YYYYMMDD',Date()));
  dbState := dsInsert;
  cid := '';
  //AObj.FieldbyName('PRINT_DATE').asString :=FormatDatetime('YYYYMMDD',Date());  // TSequence.NewId();
  //AObj.FieldbyName('GLIDE_NO').asString := '..新增..';
  // oid := AObj.FieldbyName('PRINT_DATE').asString;   //单据GUID号
  gid := inttostr(AObj.FieldbyName('PRINT_DATE').AsInteger);
  edtCREA_DATE.Date := Date();
  edtCREA_USER.KeyValue := Global.UserID;
  edtCREA_USER.Text := Global.UserName;
  InitRecord;
  if edtSHOP_ID.CanFocus and Visible then edtSHOP_ID.SetFocus;
  TabSheet.Caption := '..新增..';
  {rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CHECK_STATUS<2 ';
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=Global.SHOP_ID;
    Factor.Open(rs);
    if rs.Fields[0].AsString <> '' then
    begin
      edtSHOP_ID.KeyValue := Global.SHOP_ID;
      edtSHOP_ID.Text := Global.SHOP_NAME;
      edtCREA_DATE.Date := fnTime.fnStrtoDate(rs.Fields[0].AsString);
    end;
  finally
    rs.Free;
  end;
  }
end;

procedure TfrmCheckOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := Global.SHOP_ID;
    Params.ParamByName('PRINT_DATE').AsInteger:=StrtointDef(ID,0);    
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TPrintOrder',Params);
      Factor.AddBatch(cdsDetail,'TPrintData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    ReadFrom(cdsDetail);
    //读取计算PrintQry；
    GetPrintQryData(InttoStr(Global.TENANT_ID),Global.SHOP_ID,inttostr(AObj.fieldbyName('PRINT_DATE').AsInteger)) ;
    if (PrintQry.Active) and (edtTable.Active) then
    begin
      IsCalcRecordCount:=true;
      SetRecordCount(PrintQry.RecordCount-edtTable.RecordCount); 
      Lbl_LinkCheckGoodMouseLeave(nil);
    end;
    //判断审核：
    IsAudit :=(AObj.FieldbyName('CHECK_STATUS').AsInteger=3);
    //oid := AObj.FieldbyName('PRINT_DATE').asString;
    gid := inttostr(AObj.FieldbyName('PRINT_DATE').AsInteger);    //盘点单号
    cid := AObj.FieldbyName('SHOP_ID').asString;
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmCheckOrder.SaveOrder;
  procedure ChechPrintBillExists;  //判断盘点单是否存在
  var rs:TZQuery;
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text:='select PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE and CHECK_STATUS<3 ';
      if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
      if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=trim(edtSHOP_ID.AsString);
      if rs.Params.FindParam('PRINT_DATE')<>nil then rs.ParamByName('PRINT_DATE').AsInteger:=strtoint(formatDatetime('YYYYMMDD',edtCREA_DATE.Date));
      Factor.Open(rs);
      if rs.IsEmpty then
        Raise Exception.Create(' 没有盘点任务单,不能录入盘点单！ ');
    finally
      rs.Free;
    end;
  end;
begin
  inherited;
  IsCalcRecordCount:=False;
  Saved := false;
  if edtCREA_DATE.EditValue = null then Raise Exception.Create('盘点日期不能为空');
  if edtCREA_USER.AsString = '' then Raise Exception.Create('盘点人不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('盘点门店不能为空');

  ChechPrintBillExists;  //判断盘点单是否存在

  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  //AObj.FieldbyName('PRINT_DATE').AsString := formatdatetime('YYYYMMDD',Date());
  //AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD',Date())+' '+formatdatetime('HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := edtCREA_USER.AsString;
  cid := edtSHOP_ID.AsString;
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
      cdsDetail.FieldByName('ROWS_ID').AsString := TSequence.NewId();
      cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
      cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
      cdsDetail.FieldByName('PRINT_DATE').AsInteger := cdsHeader.FieldbyName('PRINT_DATE').AsInteger;
      cdsDetail.Post;
      cdsDetail.Next;
    end;
    Factor.AddBatch(cdsHeader,'TPrintOrder',nil);
    Factor.AddBatch(cdsDetail,'TPrintData',nil);
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  open(oid);
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmCheckOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmCheckOrder.AuditOrder;
var
  Msg,PRINT_DATE:string;
  Params:TftParamList;
  rs: TZQuery;
  op:integer;
begin
  inherited;
  if not cdsHeader.Active then Raise Exception.Create('  不能审核空单据！ ');
  PRINT_DATE:=InttoStr(cdsHeader.FieldByName('PRINT_DATE').AsInteger);
  if PRINT_DATE = '' then Raise Exception.Create(' 不能审核空单据！ ');
  if (not IsAudit) and (cdsDetail.IsEmpty) then Raise Exception.Create(' 不能审核（没有录入盘点数量商品的）空单据！ ');
  if dbState <> dsBrowse then SaveOrder;
  op := 0;
  if IsAudit then
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text:= 'select CHK_USER from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and FROM_ID=:FROM_ID and CHANGE_CODE=''1''';
        if rs.Params.ParamByName('TENANT_ID')<>nil then rs.Params.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
        if rs.Params.ParamByName('SHOP_ID')<>nil then rs.Params.ParamByName('SHOP_ID').AsString:=edtSHOP_ID.AsString;
        if rs.Params.ParamByName('FROM_ID')<>nil then rs.Params.ParamByName('FROM_ID').AsString:=inttostr(cdsHeader.fieldbyName('PRINT_DATE').AsInteger);
        Factor.Open(rs);
        if not rs.IsEmpty then
        if (rs.FieldByName('CHK_USER').AsString<>Global.UserID) then Raise Exception.Create('只有审核人才能对当前盘点任务单执行弃审');
      finally
        rs.Free;
      end;
      if MessageBox(Handle,'确认弃审当前盘点任务单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
    end
  else
    begin
      op := TfrmCheckAudit.GetCheckAudit(self,edtSHOP_ID.AsString,PRINT_DATE);
      if op<0 then Exit;
    end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').AsString := edtSHOP_ID.AsString;
      Params.ParamByName('PRINT_DATE').AsInteger :=StrtoInt(PRINT_DATE);
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      Params.ParamByName('AUDIT_FLAG').asInteger := op;
      if not IsAudit then
         Msg := Factor.ExecProc('TPrintOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TPrintOrderUnAudit',Params) ;
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
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
end;

procedure TfrmCheckOrder.edtCREA_USERSaveValue(Sender: TObject);
begin
  inherited;
  if edtCREA_USER.Text<>'' then TabSheet.Caption := edtCREA_USER.Text;
end;

procedure TfrmCheckOrder.actImportFromPrintExecute(Sender: TObject);
var
  rs:TRecordList;
  i:integer;
  tmp: TZQuery;
  s:string;
begin
  inherited;
  {
  if not ShopGlobal.GetChkRight('600041') then Raise Exception.Create('必须有库存查询权限的用户才能导入对照表.');
  if dbState = dsBrowse then Exit;
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
        tmp.SQL.Text := 'select 0 as SEQNO,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.IS_PRESENT,A.BATCH_NO,A.RCK_AMOUNT as AMOUNT,A.RCK_AMOUNT as CALC_AMOUNT,B.GODS_NAME,B.GODS_CODE,B.UNIT_ID from CHK_PRINTDATA A,VIW_GOODSINFO B '+
            'where A.GODS_ID=B.GODS_ID and A.COMP_ID=B.COMP_ID and B.COMM not in (''02'',''12'') and A.COMP_ID='''+Global.CompanyID+''' and A.PRINT_ID='''+formatDatetime('YYYYMMDD',edtCHECK_DATE.Date)+''''+s;
        Factor.Open(tmp);
        ReadFrom(tmp);
      finally
        tmp.Free;
      end;
    end;
  finally
    rs.Free;
  end;
  }
end;

procedure TfrmCheckOrder.edtCREA_USERAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  r := TRecord_.Create;
  try
    if TfrmUsersInfo.AddDialog(self,r) then
       begin
         edtCREA_USER.KeyValue := r.FieldbyName('USER_ID').AsString;
         edtCREA_USER.Text := r.FieldbyName('USER_NAME').AsString;
       end;
  finally
    r.Free;
  end;
end;

procedure TfrmCheckOrder.edtSHOP_IDSaveValue(Sender: TObject);
var rs: TZQuery;
begin
  inherited;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CHECK_STATUS<2 ';
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=Global.SHOP_ID;      
    Factor.Open(rs);
    if rs.Fields[0].AsString = '' then
    begin
      if MessageBox(Handle,'没有盘点任务单，是否立即新增？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then
      begin
        edtSHOP_ID.KeyValue := null;
        edtSHOP_ID.Text := '';
        Exit;
      end;
      //新增加盘点单
      if TfrmCheckTask.StartTask(edtSHOP_ID.AsString) then
      begin
        rs.Close;
        rs.SQL.Text := 'select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CHECK_STATUS<2 ';
        if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
        if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=Global.SHOP_ID;
        Factor.Open(rs);
      end else
      begin
        edtSHOP_ID.KeyValue := null;
        edtSHOP_ID.Text := '';
        Exit;
      end;
    end;
    edtCREA_DATE.Date := fnTime.fnStrtoDate(rs.Fields[0].AsString);
  finally
    rs.Free;
  end;   
end;

procedure TfrmCheckOrder.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
inherited;
end;

//Kind(1)1:输入 实盘 计算 盈亏; (2)2:输入 盈亏 计算 实盘
procedure TfrmCheckOrder.Calc(Kind: integer);
var Aobj: TRecord_;
begin
  if (not edtTable.Active) and (edtTable.IsEmpty) then exit;
  if trim(edtTable.FieldByName('GODS_ID').AsString)='' then exit;
  edtTable.Edit;
  try
    Aobj:=TRecord_.Create;
    Aobj.ReadFromDataSet(edtTable);
    if Kind=1 then //输入 实盘 计算 盈亏;
       begin
         Aobj.FieldByName('PAL_AMOUNT').AsFloat:=Aobj.FieldByName('RCK_AMOUNT').AsFloat-Aobj.FieldByName('AMOUNT').AsFloat;
       end
    else if Kind=2 then //输入 盈亏 计算 实盘
      Aobj.FieldByName('AMOUNT').AsFloat:=Aobj.FieldByName('RCK_AMOUNT').AsFloat-Aobj.FieldByName('PAL_AMOUNT').AsFloat;
    Aobj.FieldByName('PAL_INAMONEY').AsFloat:=roundto(Aobj.FieldbyName('NEW_INPRICE').AsFloat*Aobj.FieldByName('PAL_AMOUNT').AsFloat,-2);
    Aobj.FieldByName('PAL_OUTAMONEY').AsFloat:=roundto(Aobj.FieldbyName('NEW_OUTPRICE').AsFloat*Aobj.FieldByName('PAL_AMOUNT').AsFloat,-2);
    Aobj.WriteToDataSet(edtTable);
  finally
    Aobj.Free;
  end;
end;

procedure TfrmCheckOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs: TZQuery;
  PRINT_DATE,GodsID: string;
  SourceScale: real; //计量单位换算关系
begin
  PRINT_DATE:=InttoStr(cdsHeader.fieldbyName('PRINT_DATE').AsInteger);
  if PRINT_DATE='' then PRINT_DATE:=FormatDatetime('YYYYMMDD',Date());
 
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('在经营商品中没有找到"'+GODS_ID+'"');
  //返回计量单位的换算关系
  SourceScale := GetCalcUnitValue(GODS_ID);

  edtTable.Edit;
  edtTable.FieldbyName('NEW_INPRICE').AsFloat := rs.FieldbyName('NEW_INPRICE').AsFloat*SourceScale;
  edtTable.FieldbyName('NEW_OUTPRICE').AsFloat := rs.FieldbyName('NEW_OUTPRICE').AsFloat*SourceScale;
  edtTable.Post;

  //2011.04.02 Add 刷新账面库存
  RefreshRckAMount(SourceScale);
end;

procedure TfrmCheckOrder.GetPrintQryData(TENANT_ID,SHOP_ID,PRINT_ID: string; IsQry: Boolean);
begin
  if IsQry and (PrintQry.Active) then PrintQry.Close
  else if (not IsQry) and (PrintQry.Active) then Exit;
  PrintQry.SQL.Text:='select GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,RCK_AMOUNT from STO_PRINTDATA where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE ';
  if PrintQry.Params.FindParam('TENANT_ID')<>nil then PrintQry.ParamByName('TENANT_ID').AsString:=TENANT_ID;
  if PrintQry.Params.FindParam('SHOP_ID')<>nil then PrintQry.ParamByName('SHOP_ID').AsString:=SHOP_ID;
  if PrintQry.Params.FindParam('PRINT_DATE')<>nil then PrintQry.ParamByName('PRINT_DATE').AsInteger:=StrtoIntDef(PRINT_ID,0);
  Factor.Open(PrintQry);
end;

procedure TfrmCheckOrder.CalcRecordCount;
var
  ReSum: integer;
  CurID: string;
  myBookMark: TBookmark;
begin
  if not IsCalcRecordCount then Exit;
  if not PrintQry.Active then Exit;
  if PrintQry.IsEmpty then Exit;
  try
    ReSum:=0;
    edtTable.DisableControls;
    myBookMark:=edtTable.GetBookmark;
    edtTable.First;
    while not edtTable.Eof do
    begin
      CurID:=trim(edtTable.fieldbyName('GODS_ID').AsString);
      if PrintQry.Locate('GODS_ID',CurID,[]) then Inc(ReSum);
      edtTable.Next;
    end;
    SetRecordCount(PrintQry.RecordCount-ReSum);
  finally
    edtTable.GotoBookmark(myBookMark);
    edtTable.FreeBookMark(myBookMark);
    edtTable.EnableControls;
  end;
end;

procedure TfrmCheckOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if (edtTable.Active) and (PrintQry.Active) then 
    CalcRecordCount;  //重新计算
end;

procedure TfrmCheckOrder.Lbl_LinkCheckGoodMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Lbl_LinkCheckGood.Enabled then 
  begin  
    Lbl_LinkCheckGood.Font.Color:=clNavy;
    LblMm.Font.Color:=clRed;
  end;
end;

procedure TfrmCheckOrder.Lbl_LinkCheckGoodMouseLeave(Sender: TObject);
begin
  inherited;
  if Lbl_LinkCheckGood.Enabled then
  begin
    Lbl_LinkCheckGood.Font.Color:=clWindowText;
    LblMm.Font.Color:=clNavy;
  end;
end;

procedure TfrmCheckOrder.SetIsCalcRecordCount(const Value: Boolean);
begin
  FIsCalcRecordCount := Value;
end;

procedure TfrmCheckOrder.edtTableAfterDelete(DataSet: TDataSet);
begin
  inherited;
  if (edtTable.Active) and (PrintQry.Active) then 
    CalcRecordCount;  //重新计算
end;

procedure TfrmCheckOrder.SetRecordCount(ReSum: Integer);
begin
  if ReSum>0 then
    LblCount.Caption:=inttostr(ReSum)
  else
    LblCount.Caption:='0';
  LblMm.Visible:=(ReSum>0);  
  Lbl_LinkCheckGood.Enabled:=(ReSum>0);
  if ReSum<=0 then  
    Lbl_LinkCheckGood.Font.Color:=clGrayText
  else
    Lbl_LinkCheckGood.Font.Color:=clWindowText;
end;

procedure TfrmCheckOrder.AmountToCalc(Amount: Real);
var
  rs:TZQuery;
  AMoney,APrice,Agio_Rate,Agio_Money,SourceScale:Real;
  Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
      rs := Global.GetZQueryFromName('PUB_GOODSINFO');
      if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');  
      if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('CALC_UNITS').AsString then
         begin
          SourceScale := 1;
         end
      else
      if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('BIG_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
         end
      else
      if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('SMALL_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
         end
      else
         begin
          SourceScale := 1;
         end;
      Field := edtTable.FindField('CALC_AMOUNT');
      if Field<>nil then
         begin
            Field.AsFloat := AMount * SourceScale;
         end;
      edtProperty.Filtered := false;
      edtProperty.Filter := 'SEQNO='+edtTable.FieldbyName('SEQNO').AsString;
      edtProperty.Filtered := true;
      try
        edtProperty.First;
        while not edtProperty.Eof do
          begin
            edtProperty.Edit;
            edtProperty.FieldByName('GODS_ID').AsString := edtTable.FieldByName('GODS_ID').AsString;
            edtProperty.FieldByName('UNIT_ID').AsString := edtTable.FieldByName('UNIT_ID').AsString;
            edtProperty.FieldByName('IS_PRESENT').AsString := edtTable.FieldByName('IS_PRESENT').AsString;
            edtProperty.FieldByName('BATCH_NO').AsString := edtTable.FieldByName('BATCH_NO').AsString;
            edtProperty.FieldByName('BOM_ID').AsString := edtTable.FieldByName('BOM_ID').AsString;
            edtProperty.FieldByName('LOCUS_NO').AsString := edtTable.FieldByName('LOCUS_NO').AsString;
            edtProperty.FieldByName('CALC_AMOUNT').AsFloat := edtProperty.FieldByName('AMOUNT').AsFloat * SourceScale;
            edtProperty.Post;
            edtProperty.Next;
          end;
      finally
        edtProperty.Filtered := false;
      end;
      Calc(1);
      edtTable.Post;
      edtTable.Edit;
  finally
      Locked := false
  end;
end;

procedure TfrmCheckOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.asFloat;
     end
  else
  begin
    try
      if Text='' then r := 0 else r := StrtoFloat(Text);
      if abs(r)>999999 then Raise Exception.Create('输入的数值过大，无效');
    except
      Text := TColumnEh(Sender).Field.AsString;
      Value := TColumnEh(Sender).Field.asFloat;
      Raise Exception.Create('输入无效数值型');
    end;
    TColumnEh(Sender).Field.asFloat := r;
    AMountToCalc(r);
    //2011.02.22关闭　盘点不需要原用多个单位计算
    //   AMountToCalc(r);
    //:输入 实盘 计算 盈亏;
    Calc(1);
  end;
end;

procedure TfrmCheckOrder.Lbl_LinkCheckGoodClick(Sender: TObject);
var Print_ID,GODE_ID,BatchNo: string; CurObj: TRecord_;
begin
  if not cdsHeader.Active then exit;
  if trim(LblCount.Caption)='0' then Raise Exception.Create('  没有未录入的的商品！  '); 
  Print_ID:=InttoStr(cdsHeader.fieldbyName('PRINT_DATE').AsInteger);
  if Print_ID='' then Exit;
  with TfrmSelectCheckGoods.Create(self) do
  begin
    try
      CurObj:=TRecord_.Create;
      MultiSelect := true;
      InitGrid(Print_ID);
      if self.dbState = dsBrowse then
      begin
        MultiSelect:=False;
        chkMultSelect.Checked:=False;
        chkMultSelect.Enabled:=false;
        btnOk.Visible:=false;
        RzBitBtn2.Caption:='返回';
      end;
      if ShowModal=MROK then
      begin
        cdsList.Filtered:=False;
        cdsList.Filter:='A=1';
        cdsList.Filtered:=true;
        cdsList.First;
        try
          edtTable.DisableControls;
          edtTable.First;
          while not edtTable.Eof do
          begin
            if edtTable.FieldByName('GODS_ID').AsString='' then
              edtTable.Delete;
            edtTable.Next;
          end;
        finally
          edtTable.EnableControls;
        end;

        while not cdsList.Eof do
        begin
          CurObj.ReadFromDataSet(CdsList);
          GODE_ID:=trim(CurObj.fieldbyName('GODS_ID').AsString);
          BatchNo:=trim(CurObj.fieldbyName('BATCH_NO').AsString);
          if not edtTable.Locate('GODS_ID;BATCH_NO',VarArrayOf([GODE_ID,BatchNo]),[]) then
          begin                                  
            inc(RowId);
            edtTable.Append;
            edtTable.FieldByName('SEQNO').AsInteger:=RowId;
            edtTable.FieldByName('GODS_ID').AsString:=CurObj.FieldByName('GODS_ID').AsString;
            edtTable.FieldByName('GODS_CODE').AsString:=CurObj.FieldByName('GODS_CODE').AsString;
            edtTable.FieldByName('GODS_NAME').AsString:=CurObj.FieldByName('GODS_NAME').AsString; 
            edtTable.FieldByName('BARCODE').AsString:= EnCodeBarcode;
            edtTable.FieldByName('UNIT_ID').AsString:=CurObj.FieldByName('UNIT_ID').AsString;
            edtTable.FieldByName('IS_PRESENT').AsString:='0';
            //edtTable.FieldByName('LOCUS_NO').AsString:='';
            edtTable.FieldByName('BATCH_NO').AsString:='#';
            edtTable.FieldByName('NEW_INPRICE').AsString:=CurObj.FieldByName('NEW_INPRICE').AsString;
            edtTable.FieldByName('NEW_OUTPRICE').AsString:=CurObj.FieldByName('NEW_OUTPRICE').AsString;
            edtTable.FieldByName('RCK_AMOUNT').AsString:=CurObj.FieldByName('AMOUNT').AsString;
            edtTable.Post;
          end;
          CdsList.Next;
        end;
      end;
    finally
      CurObj.Free;
      Free;       
    end;
  end;
end;

procedure TfrmCheckOrder.UnitToCalc(UNIT_ID: string);
var AMount,SourceScale:Real;
    Field:TField;
    rs:TZQuery;
    u:integer;
begin
  if Locked then Exit;
  if UNIT_ID=edtTable.FieldbyName('UNIT_ID').AsString  then Exit;
  Locked := True;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  try
      if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');  
      Field := edtTable.FindField('CALC_AMOUNT');
      if Field=nil then Exit;
      AMount := Field.asFloat;
      if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
      edtTable.FieldByName('UNIT_ID').AsString := UNIT_ID;
      edtTable.FieldbyName('BARCODE').AsString := EnCodeBarcode;
      if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('CALC_UNITS').AsString then
         begin
          SourceScale := 1;
         end
      else
      if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('BIG_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
         end
      else
      if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('SMALL_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
         end
      else
         begin
          SourceScale := 1;
         end;
      Field := edtTable.FindField('AMOUNT');
      if Field<>nil then
         begin
            Field.AsFloat := AMount / SourceScale;
         end;
      edtTable.FieldbyName('RCK_AMOUNT').asFloat := edtTable.FieldbyName('RCK_CALC_AMOUNT').asFloat / SourceScale;
      edtProperty.Filtered := false;
      edtProperty.Filter := 'SEQNO='+edtTable.FieldbyName('SEQNO').AsString;
      edtProperty.Filtered := true;
      try
        edtProperty.First;
        while not edtProperty.Eof do
          begin
            edtProperty.Edit;
            edtProperty.FieldByName('GODS_ID').AsString := edtTable.FieldByName('GODS_ID').AsString;
            edtProperty.FieldByName('IS_PRESENT').AsString := edtTable.FieldByName('IS_PRESENT').AsString;
            edtProperty.FieldByName('BATCH_NO').AsString := edtTable.FieldByName('BATCH_NO').AsString;
            edtProperty.FieldByName('UNIT_ID').AsString := UNIT_ID;
            edtProperty.FieldByName('RCK_AMOUNT').AsFloat := edtProperty.FieldByName('RCK_CALC_AMOUNT').AsFloat / SourceScale;
            edtProperty.FieldByName('AMOUNT').AsFloat := edtProperty.FieldByName('CALC_AMOUNT').AsFloat / SourceScale;
            edtProperty.Post;
            edtProperty.Next;
          end;
      finally
        edtProperty.Filtered := false;
      end;
      InitPrice(edtTable.FieldByName('GODS_ID').asString,UNIT_ID);
      Locked := false;
      Calc(1);
  finally
     Locked := false;
  end;
end;

procedure TfrmCheckOrder.AddRecord(AObj: TRecord_; UNIT_ID: string;
  Located, IsPresent: boolean);
var
  Pt:integer;
  r:boolean;
begin
  if IsPresent then pt := 1 else pt := 0;
  if Located then
     begin
        if not gRepeat then
            begin
              r := edtTable.Locate('GODS_ID;BATCH_NO;IS_PRESENT;LOCUS_NO,BOM_ID',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,'#',pt,null,null]),[]);
              if r then
                 begin
                   if edtTable.FieldbyName('UNIT_ID').asString<>UNIT_ID then
                      UnitToCalc(UNIT_ID);
                   Exit;
                 end;
            end;
        inc(RowID);
        if (edtTable.FieldbyName('GODS_ID').asString='') and (edtTable.FieldbyName('SEQNO').asString<>'') then
        edtTable.Edit else InitRecord;
        edtTable.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
        edtTable.FieldbyName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
        edtTable.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
        edtTable.FieldByName('IS_PRESENT').asInteger := pt;
        if UNIT_ID='' then
           edtTable.FieldbyName('UNIT_ID').AsString := AObj.FieldbyName('UNIT_ID').AsString
        else
           edtTable.FieldbyName('UNIT_ID').AsString := UNIT_ID;
        edtTable.FieldbyName('BATCH_NO').AsString := '#';
     end;
  edtTable.Edit;
  edtTable.FieldbyName('BARCODE').AsString := EncodeBarcode;
  InitPrice(AObj.FieldbyName('GODS_ID').AsString,UNIT_ID);
end;

procedure TfrmCheckOrder.CheckInvaid;
var
  bs:TZQuery;
  r:integer;
begin
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  r := edtTable.RecNo;
  edtTable.DisableControls;
  try
    edtTable.First;
    while not edtTable.eof do
      begin
        if not bs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create(edtTable.FieldbyName('GODS_NAME').asString+'在经营商品中没有找到.');
        if (bs.FieldByName('USING_BATCH_NO').AsString = '1') and (edtTable.FieldbyName('BATCH_NO').AsString='#') then Raise Exception.Create(edtTable.FieldbyName('GODS_NAME').asString+'商品必须输入商品批号。');
        edtTable.Next;
      end;
    if r>0 then edtTable.RecNo := r;
  finally
    edtTable.EnableControls;
  end;
end;

function TfrmCheckOrder.CheckInput: boolean;
begin
  result := pos(inttostr(InputFlag),'089')>0;
end;

function TfrmCheckOrder.CheckRepeat(AObj: TRecord_;
  var pt: boolean): boolean;
var
  r,c:integer;
begin
  result := false;
  r := edtTable.FieldbyName('SEQNO').AsInteger;
  edtTable.DisableControls;
  try
    c := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        if
           (edtTable.FieldbyName('GODS_ID').AsString = AObj.FieldbyName('GODS_ID').AsString)
           and
           (edtTable.FieldbyName('BATCH_NO').AsString = AObj.FieldbyName('BATCH_NO').AsString)
           and
           (edtTable.FieldbyName('SEQNO').AsInteger <> r)
        then
           begin
             inc(c);
             break;
           end;
        edtTable.Next;
      end;
    pt := false;
    if c>0 then
      begin
        if gRepeat and (MessageBox(Handle,pchar('"'+AObj.FieldbyName('GODS_NAME').asString+'('+AObj.FieldbyName('GODS_CODE').asString+')已经存在，是否继续添加赠品？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)=6) then
           result := false else result := true;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
end;

function TfrmCheckOrder.GetCalcUnitValue(GODS_ID: string): Real;
var
  rs: TZQuery;
begin
  result:=1.0;  //默认返回:1.0
  if not edtTable.Active then Exit;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('在经营商品中没有找到"'+GODS_ID+'"');
  if trim(edtTable.FieldByName('UNIT_ID').AsString)=trim(rs.FieldByName('CALC_UNITS').AsString) then
    result := 1
  else if trim(edtTable.FieldByName('UNIT_ID').AsString)=trim(rs.FieldByName('BIG_UNITS').AsString) then
    result := rs.FieldByName('BIGTO_CALC').asFloat
  else if trim(edtTable.FieldByName('UNIT_ID').AsString)=trim(rs.FieldByName('SMALL_UNITS').AsString) then
    result := rs.FieldByName('SMALLTO_CALC').asFloat;
end;

procedure TfrmCheckOrder.RefreshRckAMount(CalcValue: real=0);
var
  rs: TZQuery;
  IsExists: Boolean;
  SourceScale: real;
  GodsID,BatchNo,PROPERTY_01,PROPERTY_02: string;
begin
  if (PrintQry.Active) and (edtTable.Active) then
  begin
    GodsID:=trim(edtTable.FieldbyName('GODS_ID').AsString);  
    if CalcValue=0 then  //等于0则需要重新计算值
      SourceScale:=GetCalcUnitValue(GodsID)
    else
      SourceScale:=CalcValue; //直接外部传入的换算值      

    BatchNo:=trim(edtTable.FieldbyName('BATCH_NO').AsString);
    PROPERTY_01:=trim(edtTable.FieldbyName('PROPERTY_01').AsString);
    PROPERTY_02:=trim(edtTable.FieldbyName('PROPERTY_02').AsString);
    if PROPERTY_01='' then PROPERTY_01:='#';
    if PROPERTY_02='' then PROPERTY_02:='#';
    IsExists:=PrintQry.Locate('GODS_ID;BATCH_NO;PROPERTY_01;PROPERTY_02',VarArrayOf([GodsID,BatchNo,PROPERTY_01,PROPERTY_02]),[]);

    edtTable.Edit;
    if IsExists then
    begin
      edtTable.FieldbyName('RCK_AMOUNT').AsFloat := PrintQry.FieldbyName('RCK_AMOUNT').AsFloat/SourceScale;
      edtTable.FieldbyName('RCK_CALC_AMOUNT').AsFloat := PrintQry.FieldbyName('RCK_AMOUNT').AsFloat;
    end else
    begin
      edtTable.FieldbyName('RCK_AMOUNT').AsFloat := 0;
      edtTable.FieldbyName('RCK_CALC_AMOUNT').AsFloat:=0;
    end;
    edtTable.Post;
  end;
end;


function TfrmCheckOrder.GodsToBatchNo(id: string): boolean;
begin
  inherited GodsToBatchNo(id);
  //2011.04.02 Add 刷新账面库存
  RefreshRckAMount;
end;

end.
