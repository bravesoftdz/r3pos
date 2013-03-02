unit ufrmOrderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, Grids, DBGridEh, StdCtrls,
  RzLabel, cxControls, cxContainer, cxEdit, cxTextEdit, cxDropDownEdit,
  cxCalendar, cxMaskEdit, cxButtonEdit, zrComboBoxList, RzButton, RzBmpBtn,
  RzTabs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, Math;

const

  WM_DIALOG_PULL=WM_USER+1;
  //状态改变
  WM_STATUS_CHANGE=WM_USER+2;
  //单据操作
  WM_EXEC_ORDER=WM_USER+3;

  WM_INIT_RECORD=WM_USER+4;
  WM_NEXT_RECORD=WM_USER+5;
  WM_PRIOR_RECORD=WM_USER+6;
  WM_JOIN_DATA=WM_USER+8;
  //填充数据
  WM_FILL_DATA=WM_USER+7;
  //尺码，颜色编辑框
  PROPERTY_DIALOG=1;
  //批号、有效期输入框
  BATCH_NO_DIALOG=2;
  //添加商品对话框
  ADD_GOODS_DIALOG=3;
  //查询商品对话框
  FIND_GOODS_DIALOG=4;
type
  TfrmOrderForm = class(TfrmWebToolForm)
    RzLabel1: TRzLabel;
    RzPanel12: TRzPanel;
    RzBitBtn5: TRzBitBtn;
    PageControl: TRzPageControl;
    TabSheet1: TRzTabSheet;
    order_input: TRzPanel;
    RzPanel2: TRzPanel;
    lblInput: TLabel;
    lblHint: TLabel;
    edtInput: TcxTextEdit;
    RzBmpButton2: TRzBmpButton;
    order_header: TRzPanel;
    order_grid: TRzPanel;
    DBGridEh1: TDBGridEh;
    order_footer: TRzPanel;
    edtTable: TZQuery;
    dsTable: TDataSource;
    edtProperty: TZQuery;
    fndGODS_ID: TzrComboBoxList;
    fndUNIT_ID: TcxComboBox;
    procedure RzBmpButton2Click(Sender: TObject);
    procedure edtInputExit(Sender: TObject);
    procedure edtInputEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fndGODS_IDEnter(Sender: TObject);
    procedure fndGODS_IDExit(Sender: TObject);
    procedure fndGODS_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fndGODS_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure DBGridEh1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    //SEQNO控制号
    FinputFlag: integer;
    FinputMode: integer;
    FdbState: TDataSetState;

    // 散装条码参数
    BulkiFlag:string;
    BulkId:integer;
    Bulk1Flag:integer;
    Bulk2Flag:integer;
    Bulk1Len:integer;
    Bulk2Len:integer;
    Bulk1Dec:integer;
    Bulk2Dec:integer;

    //临时变量
    fndStr:string;
    RowID:integer;
    Locked:boolean;
    // 最近输的货品
    vgds,vP1,vP2,vBtNo:string;

    procedure SetinputFlag(const Value: integer);
    procedure SetinputMode(const Value: integer);
    procedure SetdbState(const Value: TDataSetState);
    { Private declarations }
  protected
    procedure InitRecord;
    function EnCodeBarcode: string;
    function CheckInput:boolean;virtual;

    function  FindColumn(FieldName:string):TColumnEh;
    procedure FocusColumn(FieldName: string);
    procedure FocusNextColumn;

    //清除无效数据
    procedure ClearInvaid;virtual;
    //检测数据合法性
    procedure CheckInvaid;virtual;

    function PropertyEnabled:boolean;
    //检测是否是汇总字段
    function CheckSumField(FieldName:string):boolean;virtual;
    procedure AddRecord(AObj:TRecord_;UNIT_ID:string);virtual;
    procedure UpdateRecord(AObj:TRecord_;UNIT_ID:string);virtual;
    procedure DelRecord(AObj:TRecord_);virtual;
    procedure EraseRecord;virtual;
    procedure InitPrice(GODS_ID,UNIT_ID:string);virtual;
    function CheckRepeat(AObj:TRecord_):boolean;virtual;

    procedure AmountToCalc(Amount:Real);virtual;
    procedure PriceToCalc(APrice:Real);virtual;
    procedure AMoneyToCalc(AMoney:Real);virtual;
    procedure BulkToCalc(AMoney:Real);virtual;
    procedure AgioToCalc(Agio:Real);virtual;
    procedure PresentToCalc(Present:integer);virtual;
    procedure UnitToCalc(UNIT_ID:string);virtual;
    procedure WriteAmount(UNIT_ID,PROPERTY_01,PROPERTY_02:string;Amt:real;Appended:boolean=false);virtual;
    procedure BulkAmount(UNIT_ID:string;Amt,Pri,mny:real;Appended:boolean=false);virtual;

    //输入会员号
    procedure WriteInfo(id:string);virtual;
    //整单折扣
    procedure AgioInfo(id:string);virtual;
    //单笔折扣
    procedure AgioToGods(id:string);virtual;
    //修改单价
    procedure PriceToGods(id:string);virtual;
    //输入跟踪号
    function GodsToLocusNo(id:string):boolean;virtual;
    //输入批号
    function GodsToBatchNo(id:string):boolean;virtual;
    //输入数量
    procedure GodsToAmount(id:string);virtual;
    
    procedure ReadFrom(DataSet:TDataSet);virtual;
    procedure CalcWriteTo(edtTable,DataSet:TDataSet;MyField:TField);virtual;
    procedure WriteTo(DataSet:TDataSet);virtual;

    function DecodeBarcode(BarCode: string):integer;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure NewOrder;virtual;
    procedure EditOrder;virtual;
    procedure DeleteOrder;virtual;
    procedure SaveOrder;virtual;
    procedure CancelOrder;virtual;
    procedure AuditOrder;virtual;
    procedure PrintOrder;virtual;
    procedure PreviewOrder;virtual;
    procedure Open(id:string);virtual;
    
    property inputFlag:integer read FinputFlag write SetinputFlag;
    property inputMode:integer read FinputMode write SetinputMode;
    //单据状态
    property dbState:TDataSetState read FdbState write SetdbState;

  end;

var
  frmOrderForm: TfrmOrderForm;

implementation

uses udllGlobal,ufrmFindDialog,udllXDictFactory,utokenFactory,udllFnUtil,udllDsUtil,udllShopUtil,
  udataFactory;

{$R *.dfm}

{ TfrmOrderForm }

procedure TfrmOrderForm.SetinputFlag(const Value: integer);
begin
  FinputFlag := Value;
  case inputFlag of
  0:begin
      lblInput.Caption := '条码输入';
      lblHint.Caption := '请用扫码枪对准商品条码标签，如果无法扫码可用健盘输入条码数字串后按回车';
    end;
  1:begin
      lblInput.Caption := '会员卡号';
      lblHint.Caption := '请输入完整的(会员卡号)后按“回车”';
    end;
  2:begin
      lblInput.Caption := '整单折扣';
      lblHint.Caption := '请输入整单折扣率(如:8折、85折)后按“回车”';
    end;
  3:begin
      lblInput.Caption := '修改单价';
      lblHint.Caption := '请直接输入单价后按“回车”';
    end;
  4:begin
      lblInput.Caption := '单笔折扣';
      lblHint.Caption := '请直接输入当前商品的折扣率(如:8折、85折)后按“回车”';
    end;
  5:begin
      lblInput.Caption := '单位切换';
      lblHint.Caption := '请按 tab 健进行单位转换';
    end;
  6:begin
      lblInput.Caption := '赠品/兑换';
      lblHint.Caption := '请按 tab 健进行"正常/赠品/兑换"转换';
    end;
  7:begin
      lblInput.Caption := '物流条码';
      lblHint.Caption := '请输入物流跟踪号后按“回车”';
    end;
  8:begin
      lblInput.Caption := '商品批号';
      lblHint.Caption := '请输入商品批号后按“回车”';
    end;
  9:begin
      lblInput.Caption := '数量输入';
      lblHint.Caption := '请输入商品批号后按“回车”';
    end;
  end;
  if not CheckInput then InputFlag := 0;
end;

procedure TfrmOrderForm.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  if order_input.Height=66 then
     order_input.Height := 147
  else
     order_input.Height := 66;
  ajustPostion;
end;

procedure TfrmOrderForm.SetinputMode(const Value: integer);
begin
  FinputMode := Value;
  case Value of
  0:begin //传统输入
      edtInput.Visible := false;
      lblHint.Visible := false;
      lblInput.Caption := '请按【F2】进入快捷输入模式...';
      lblInput.Font.Color := clRed ;
    end;
  1:begin //快捷输入
      edtInput.Visible := true;
      lblHint.Visible := true;
      lblInput.Font.Color := clNavy ;
    end;
  end;
end;

constructor TfrmOrderForm.Create(AOwner: TComponent);
var
  i:integer;
  rs:TZQuery;
  Column:TColumnEh;
begin
  inherited;
  inputMode := 1;
  for i:=0 to PageControl.PageCount - 1 do PageControl.Pages[i].TabVisible := false;
  fndGODS_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn('UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString)
      rs.Next;
    end;
end;

destructor TfrmOrderForm.Destroy;
begin
  inherited;
end;

procedure TfrmOrderForm.edtInputExit(Sender: TObject);
begin
  inherited;
//  inputMode := 0;

end;

procedure TfrmOrderForm.edtInputEnter(Sender: TObject);
begin
  inherited;
  inputMode := 1;

end;

procedure TfrmOrderForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
     begin
       inputMode := 1;
       inputFlag := 0;
       edtInput.SetFocus;
     end;
end;

procedure TfrmOrderForm.fndGODS_IDEnter(Sender: TObject);
begin
  inherited;
  fndGODS_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;

end;

procedure TfrmOrderForm.fndGODS_IDExit(Sender: TObject);
begin
  inherited;
  if not fndGODS_ID.DropListed then fndGODS_ID.Visible := false;

end;

procedure TfrmOrderForm.fndGODS_IDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key=VK_RIGHT) and not fndGODS_ID.Edited then
     begin
       DBGridEh1.SetFocus;
       fndGODS_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not fndGODS_ID.DropListed then
     begin
       DBGridEh1.SetFocus;
       fndGODS_ID.Visible := false;
       edtTable.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not fndGODS_ID.DropListed then
     begin
       if (edtTable.FieldByName('SEQNO').AsString<>'') and (edtTable.FieldByName('GODS_ID').AsString='') then
         fndGODS_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         fndGODS_ID.Visible := false;
         edtTable.Next;
         if edtTable.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if edtTable.FieldByName('GODS_ID').AsString <> '' then
            Key := 0
       end;
     end;

end;

procedure TfrmOrderForm.fndGODS_IDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       if edtTable.FieldbyName('GODS_ID').AsString = '' then
          begin
            fndGODS_ID.DropList;
            Exit;
          end;
       DBGridEh1.SetFocus;
       FocusNextColumn;
     end;
end;

function TfrmOrderForm.FindColumn(FieldName: string): TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh1.Columns[i];
           Exit;
         end;
    end;
end;

procedure TfrmOrderForm.FocusColumn(FieldName: string);
var i:integer;
begin
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           DBGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmOrderForm.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  if (edtTable.RecordCount>edtTable.RecNo) and (DbGridEh1.Columns[i].Control=nil) then
     begin
       edtTable.Next;
       Exit;
     end;
  Inc(i);
  while True do
    begin
      if i>=DbGridEh1.Columns.Count then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(edtTable.FieldbyName('GODS_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(edtTable.FieldbyName('GODS_ID').asString)<>'') then
              begin
                 edtTable.Next ;
                 if edtTable.Eof then
                    begin
                      InitRecord;
                    end;
                 DbGridEh1.SetFocus;
                 DbGridEh1.Col := 1 ;
              end
           else
              DbGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmOrderForm.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  fndGODS_ID.Visible := false;
  edtTable.DisableControls;
  try
  edtTable.Last;
  if edtTable.IsEmpty or (edtTable.FieldbyName('GODS_ID').AsString <>'') then
    begin
      inc(RowID);
      edtTable.Append;
      edtTable.FieldByName('GODS_ID').Value := null;
      edtTable.FieldByName('IS_PRESENT').Value := 0;
      if edtTable.FindField('SEQNO')<> nil then
         edtTable.FindField('SEQNO').asInteger := RowID;
      edtTable.Post;
    end;
    DbGridEh1.Col := 1 ;
    if DBGridEh1.CanFocus and Visible and not edtInput.Focused and (dbState <> dsBrowse) then DBGridEh1.SetFocus;
  finally
    edtTable.EnableControls;
    edtTable.Edit;
  end;
end;
procedure TfrmOrderForm.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);
  DBGridEh1.ReadOnly := (Value=dsBrowse);
end;

procedure TfrmOrderForm.CheckInvaid;
var
  bs:TZQuery;
  r:integer;
  Controls:boolean;
begin
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  r := edtTable.RecNo;
  Controls := edtTable.ControlsDisabled;
  edtTable.DisableControls;
  try
    edtTable.First;
    while not edtTable.eof do
      begin
        if not bs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create(edtTable.FieldbyName('GODS_NAME').asString+'在经营商品中没有找到.');
        if (bs.FieldByName('USING_BATCH_NO').AsString = '1') and (edtTable.FindField('BATCH_NO')<>nil) and (edtTable.FieldbyName('BATCH_NO').AsString='#') then Raise Exception.Create(edtTable.FieldbyName('GODS_NAME').asString+'商品必须输入商品批号。');
        if (bs.FieldByName('USING_LOCUS_NO').AsString = '1') and (edtTable.FindField('AMOUNT')<>nil) and (edtTable.FieldbyName('AMOUNT').AsCurrency<>edtTable.FieldbyName('AMOUNT').AsInteger) then Raise Exception.Create(edtTable.FieldbyName('GODS_NAME').asString+'商品不能输入小数的数量。');
        edtTable.Next;
      end;
    if r>0 then edtTable.RecNo := r;
  finally
    if not Controls then edtTable.EnableControls;
  end;
end;

function TfrmOrderForm.CheckSumField(FieldName: string): boolean;
var s:string;
begin
  s := uppercase(FieldName);
  result := (s='AMOUNT') or (s='CALC_AMOUNT') or (s='AMONEY') or (s='CALC_MONEY') or (s='AGIO_MONEY');
end;

procedure TfrmOrderForm.ClearInvaid;
var
  Field:TField;
  Controls:boolean;
  r:integer;
begin
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  Field := edtTable.FindField('AMOUNT');
  Controls := edtTable.ControlsDisabled;
  r := edtTable.RecNo;
  edtTable.DisableControls;
  try
  edtTable.First;
  while not edtTable.Eof do
    begin
      if (edtTable.FieldByName('GODS_ID').AsString = '')
         or
         ( (Field<>nil) and (Field.AsFloat=0) )
      then
         edtTable.Delete
      else
         edtTable.Next;
    end;
  finally
    if r>0 then edtTable.RecNo := r;
    if not Controls then  edtTable.EnableControls;
  end;
end;

function TfrmOrderForm.EnCodeBarcode:string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select BARCODE,UNIT_ID from PUB_BARCODE where TENANT_ID in ('+dllGlobal.GetTenantId+') and GODS_ID=:GODS_ID and BARCODE_TYPE in (''0'',''1'',''2'') order by BARCODE_TYPE';
    rs.ParamByName('GODS_ID').AsString := edtTable.FieldbyName('GODS_ID').AsString;
    dataFactory.MoveToSqlite;
    try
      dataFactory.Open(rs);
      if rs.Locate('UNIT_ID',edtTable.FieldbyName('UNIT_ID').asString,[]) then
         result := rs.FieldbyName('BARCODE').asString
      else
         begin
           rs.First;
           result := rs.FieldbyName('BARCODE').asString;
         end;
    finally
      dataFactory.MoveToDefault;
    end;
  finally
    rs.free;
  end;
end;
procedure TfrmOrderForm.AddRecord(AObj: TRecord_; UNIT_ID: string);
var
  Pt:integer;
  r:boolean;
begin
  pt := 0;
  if UNIT_ID='' then UNIT_ID := AObj.FieldbyName('UNIT_ID').AsString;
  r := edtTable.Locate('GODS_ID;BATCH_NO;UNIT_ID;IS_PRESENT;LOCUS_NO;BOM_ID',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,'#',UNIT_ID,pt,null,null]),[]);
  if r then Exit;
  inc(RowID);
  if (edtTable.FieldbyName('GODS_ID').asString='') and (edtTable.FieldbyName('SEQNO').asString<>'') then
  edtTable.Edit else InitRecord;
  edtTable.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
  edtTable.FieldbyName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
  edtTable.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
  edtTable.FieldByName('IS_PRESENT').asInteger := 0;
  if UNIT_ID='' then
     edtTable.FieldbyName('UNIT_ID').AsString := AObj.FieldbyName('UNIT_ID').AsString
  else
     edtTable.FieldbyName('UNIT_ID').AsString := UNIT_ID;
  edtTable.FieldbyName('BATCH_NO').AsString := '#';

  edtTable.Edit;
  edtTable.FieldbyName('BARCODE').AsString := EncodeBarcode;
  InitPrice(AObj.FieldbyName('GODS_ID').AsString,UNIT_ID);
end;

procedure TfrmOrderForm.CalcWriteTo(edtTable, DataSet: TDataSet;
  MyField: TField);
var
    AMoney,APrice,ACalcMoney,Agio_Rate,Agio_Money:Real;
    Field:TField;
begin
  if MyField=nil then Exit;
  DataSet.FieldByName(MyField.FieldName).asFloat := MyField.asFloat;
  if MyField.FieldName <> 'AMOUNT' then Exit;
  if Locked then Exit;
  Locked := true;
  try
      Field := edtTable.FindField('APRICE');
      if Field=nil then Exit;
      //取单价
      APrice := Field.asFloat;
      //算金额
      AMoney := APrice * MyField.AsFloat;
      Field := edtTable.FindField('AMONEY');
      if Field<>nil then
         DataSet.FieldByName('AMONEY').AsString := FormatFloat('#0.000',AMoney);
         
      if edtTable.FindField('ORG_PRICE') = nil then
        begin
          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if Field<>nil then
             Agio_Rate := (Field.AsFloat / 100)
          else
             Agio_Rate := 1;
          //如果=0为不打折
          if Agio_Rate=0 then Agio_Rate := 1;

          Agio_Money := (AMoney/Agio_Rate) - AMoney;
        end
      else
        begin
          if edtTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := edtTable.FindField('ORG_PRICE').AsFloat*MyField.AsFloat-AMoney;

          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if (Field<>nil) and (MyField.AsFloat<>0) then
             begin
                if edtTable.FindField('ORG_PRICE').AsFloat<>0 then
                   DataSet.FindField('AGIO_RATE').AsString := formatFloat('#0.000',AMoney *100 /(edtTable.FindField('ORG_PRICE').AsFloat*MyField.AsFloat))
                else
                   DataSet.FindField('AGIO_RATE').AsString := '100';
             end;
        end;
        
      Field := DataSet.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.000',Agio_Money);

      if edtTable.FieldByName('IS_PRESENT').AsInteger =1 then
         ACalcMoney := 0
      else
         ACalcMoney := AMoney;

      Field := DataSet.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.000',ACalcMoney) ;
  finally
      Locked := false
  end;
end;

procedure TfrmOrderForm.DelRecord(AObj: TRecord_);
begin
  if not edtTable.IsEmpty then edtTable.Delete;

end;

procedure TfrmOrderForm.EraseRecord;
var i:integer;
begin
  if edtTable.State = dsBrowse then edtTable.Edit;
  for i:=1 to edtTable.Fields.Count -1 do edtTable.Fields[i].Value := null;
  fndGODS_ID.Text := '';
  fndGODS_ID.KeyValue := null;
end;

procedure TfrmOrderForm.ReadFrom(DataSet: TDataSet);
var
  i:integer;
  r:boolean;
  hasPrice:boolean;
begin
  edtProperty.Close;
  edtTable.Close;
  edtProperty.CreateDataSet;
  edtTable.CreateDataSet;
  edtTable.DisableControls;
  hasPrice := (edtTable.FindField('APRICE')<>nil);
  try
  RowID := 0;
  DataSet.First;
  while not DataSet.Eof do
    begin
      if hasPrice then
         r := edtTable.Locate('GODS_ID;BATCH_NO;UNIT_ID;BOM_ID;LOCUS_NO;IS_PRESENT;APRICE',
              VarArrayOf([DataSet.FieldbyName('GODS_ID').asString,
                        DataSet.FieldbyName('BATCH_NO').asString,
                        DataSet.FieldbyName('UNIT_ID').asString,
                        DataSet.FieldbyName('BOM_ID').Value,
                        DataSet.FieldbyName('LOCUS_NO').Value,
                        DataSet.FieldbyName('IS_PRESENT').asInteger,DataSet.FieldbyName('APRICE').AsCurrency]),[])
      else
         r := edtTable.Locate('GODS_ID;BATCH_NO;UNIT_ID;BOM_ID;LOCUS_NO;IS_PRESENT',
              VarArrayOf([DataSet.FieldbyName('GODS_ID').asString,
                        DataSet.FieldbyName('BATCH_NO').asString,
                        DataSet.FieldbyName('UNIT_ID').asString,
                        DataSet.FieldbyName('BOM_ID').Value,
                        DataSet.FieldbyName('LOCUS_NO').Value,
                        DataSet.FieldbyName('IS_PRESENT').asInteger]),[]);
      if r then
      begin
        edtTable.Edit;
        for i:=0 to edtTable.Fields.Count -1 do
          begin
            if (edtTable.Fields[i].FieldName<>'SEQNO') and (DataSet.FindField(edtTable.Fields[i].FieldName)<>nil) then
            begin
              if CheckSumField(edtTable.Fields[i].FieldName) then
                edtTable.Fields[i].AsFloat := edtTable.Fields[i].AsFloat + DataSet.FieldbyName(edtTable.Fields[i].FieldName).AsFloat
              else
                edtTable.Fields[i].Value := DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value;
            end;
          end;
        edtTable.Post;
      end
      else
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
      end;
      edtProperty.Append;
      for i:=0 to edtProperty.Fields.Count -1 do
        edtProperty.Fields[i].Value := DataSet.FieldbyName(edtProperty.Fields[i].FieldName).Value;
      edtProperty.FieldByName('SEQNO').AsInteger := edtTable.FieldbyName('SEQNO').AsInteger; 
      edtProperty.Post;
      DataSet.Next;
    end;
    edtTable.SortedFields := 'SEQNO';
  finally
    edtTable.EnableControls;
  end;
end;

procedure TfrmOrderForm.UpdateRecord(AObj: TRecord_; UNIT_ID: string);
var Field:TField;
begin
  if edtTable.State = dsBrowse then
     begin
       if edtTable.FieldbyName('SEQNO').asString='' then
          InitRecord else edtTable.Edit;
     end;
  edtTable.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
  edtTable.FieldByName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
  edtTable.FieldByName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
  edtTable.FieldByName('UNIT_ID').AsString := AObj.FieldbyName('UNIT_ID').AsString;
  edtTable.FieldByName('IS_PRESENT').AsInteger := 0;
  edtTable.FieldbyName('BATCH_NO').AsString := '#';
  edtTable.FieldbyName('BARCODE').AsString := EncodeBarcode;
  edtProperty.Filtered := false;
  edtProperty.Filter := 'SEQNO='+edtTable.FieldbyName('SEQNO').AsString;
  edtProperty.Filtered := true;
  try
    edtProperty.First;
    while not edtProperty.Eof do edtProperty.Delete;
  finally
    edtProperty.Filtered := false;
  end;
  InitPrice(AObj.FieldbyName('GODS_ID').AsString,edtTable.FieldByName('UNIT_ID').AsString);
  Field := edtTable.FindField('AMOUNT');
  if Field<>nil then
     begin
       if PropertyEnabled then
          begin
            edtTable.Edit;
            Field.AsFloat := 0;
          end;
       AMountToCalc(Field.AsFloat);
     end
end;

procedure TfrmOrderForm.WriteTo(DataSet: TDataSet);
var
  i,r:integer;
  bs:TZQuery;
  lc,hasPrice:boolean;
begin
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  edtTable.DisableControls;
  try
  bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  DataSet.First;
  while not DataSet.Eof do DataSet.Delete;
  hasPrice := (edtTable.FindField('APRICE')<>nil);
  edtTable.First;
  while not edtTable.Eof do
    begin
      if not bs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) then
         Raise Exception.Create('在经营品牌中没找到"'+edtTable.FieldbyName('GODS_NAME').AsString+'('+edtTable.FieldbyName('GODS_CODE').AsString+')'+'"');
      if ((bs.FieldbyName('SORT_ID7').AsString = '') or (bs.FieldbyName('SORT_ID7').AsString = '#'))
         and
         ((bs.FieldbyName('SORT_ID8').AsString = '') or (bs.FieldbyName('SORT_ID8').AsString = '#'))
      then
         begin
           if HasPrice then
              lc := DataSet.Locate('GODS_ID;BATCH_NO;UNIT_ID;IS_PRESENT;LOCUS_NO,BOM_ID;APRICE',
                   VarArrayOf([edtTable.FieldbyName('GODS_ID').AsString,
                            edtTable.FieldbyName('BATCH_NO').AsString,
                            edtTable.FieldbyName('UNIT_ID').AsString,
                            edtTable.FieldbyName('LOCUS_NO').Value,
                            edtTable.FieldbyName('BOM_ID').Value,
                            edtTable.FieldbyName('IS_PRESENT').AsInteger,edtTable.FieldbyName('APRICE').AsCurrency]),[])
           else
              lc := DataSet.Locate('GODS_ID;BATCH_NO;UNIT_ID;IS_PRESENT;LOCUS_NO,BOM_ID',
                   VarArrayOf([edtTable.FieldbyName('GODS_ID').AsString,
                            edtTable.FieldbyName('BATCH_NO').AsString,
                            edtTable.FieldbyName('UNIT_ID').AsString,
                            edtTable.FieldbyName('IS_PRESENT').AsInteger,
                            edtTable.FieldbyName('LOCUS_NO').Value,
                            edtTable.FieldbyName('BOM_ID').Value
                            ]),[]);
                            
           if lc then Raise Exception.Create('"'+edtTable.FieldbyName('GODS_NAME').AsString+'"货品重复录入,请核对输入是否正确.');

           DataSet.Append;
           inc(r);
           for i:=0 to edtTable.Fields.Count -1 do
             begin
               if DataSet.FindField(edtTable.Fields[i].FieldName)<>nil then
                  DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value := edtTable.Fields[i].Value;
             end;
           DataSet.FieldbyName('SEQNO').AsInteger := r;
           DataSet.FieldByName('PROPERTY_01').AsString := '#';
           DataSet.FieldByName('PROPERTY_02').AsString := '#';
           DataSet.Post;
         end
      else
         begin
           edtProperty.Filtered := false;
           edtProperty.Filter := 'SEQNO='+edtTable.FieldbyName('SEQNO').asString;
           edtProperty.Filtered := true;
           edtProperty.First;
           while not edtProperty.Eof do
             begin
               DataSet.Append;
               inc(r);
               for i:=0 to edtTable.Fields.Count -1 do
                  begin
                    if DataSet.FindField(edtTable.Fields[i].FieldName)<>nil then
                    begin
                      if not CheckSumField(edtTable.Fields[i].FieldName) then
                         DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value := edtTable.Fields[i].Value
                      else
                         CalcWriteTo(edtTable,DataSet,edtProperty.FindField(edtTable.Fields[i].FieldName));
                    end;
                  end;
               DataSet.FieldbyName('SEQNO').AsInteger := r;
               DataSet.FieldByName('PROPERTY_01').AsString := edtProperty.FieldByName('PROPERTY_01').AsString;
               DataSet.FieldByName('PROPERTY_02').AsString := edtProperty.FieldByName('PROPERTY_02').AsString;
               DataSet.Post;
               edtProperty.Next;
             end;
         end;
      edtTable.Next;
    end;

  if DataSet.IsEmpty then Raise Exception.Create('不能保存一张空单..');
  finally
    edtTable.EnableControls;
  end;
end;

procedure TfrmOrderForm.InitPrice(GODS_ID, UNIT_ID: string);
begin

end;

procedure TfrmOrderForm.AmountToCalc(Amount: Real);
var
  rs:TZQuery;
  AMoney,APrice,Agio_Rate,Agio_Money,SourceScale:Real;
  Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
      rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
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
      Field := edtTable.FindField('APRICE');
      if Field=nil then Exit;
      Field.AsString := FormatFloat('#0.000',Field.AsFloat);
      //取单价
      APrice := Field.asFloat;
      //算金额
      AMoney := StrtoFloat(FormatFloat('#0.00',APrice * AMount));
      Field := edtTable.FindField('AMONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney);
      if edtTable.FindField('ORG_PRICE') = nil then
        begin
          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if Field<>nil then
             Agio_Rate := (Field.AsFloat / 100)
          else
             Agio_Rate := 1;
          //如果=0为不打折
          if Agio_Rate=0 then Agio_Rate := 1;

          Agio_Money := (AMoney/Agio_Rate) - AMoney;
        end
      else
        begin
          if edtTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := edtTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if (Field<>nil) and (AMount<>0) then
             begin
                if edtTable.FindField('ORG_PRICE').AsFloat<>0 then
                   Field.AsString := formatFloat('#0.0',AMoney *100 /(edtTable.FindField('ORG_PRICE').AsFloat*Amount))
                else
                   Field.AsString := '100';
             end;
        end;
      Field := edtTable.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',Agio_Money);

      Field := edtTable.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney) ;
      edtTable.Post;
      edtTable.Edit;
  finally
      Locked := false
  end;
end;

procedure TfrmOrderForm.PriceToCalc(APrice: Real);
var AMount,AMoney,Agio_Rate,Agio_Money:Real;
    Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
      Field := edtTable.FindField('APRICE');
      if Field=nil then Exit;
      Field.AsString := FormatFloat('#0.000',APrice);
      APrice := Field.AsFloat;

      Field := edtTable.FindField('AMOUNT');
      if Field=nil then Exit;
      //取数量
      AMount := Field.asFloat;
      //金额
      AMoney := StrtoFloat(FormatFloat('#0.00',AMount * APrice));
      Field := edtTable.FindField('AMONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney);

      if edtTable.FindField('ORG_PRICE')=nil then
        begin
          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if Field<>nil then
             Agio_Rate := (Field.AsFloat / 100)
          else
             Agio_Rate := 1;
          //如果=0为不打折
          if Agio_Rate=0 then Agio_Rate := 1;

          Agio_Money := (AMoney/Agio_Rate ) - AMoney;
        end
      else
        begin
          if edtTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := edtTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if (Field<>nil) and (AMount<>0) then
             begin
                if edtTable.FindField('ORG_PRICE').AsFloat<>0 then
                   Field.AsString := formatFloat('#0.0',AMoney *100 /(edtTable.FindField('ORG_PRICE').AsFloat*Amount))
                else
                   Field.AsString := '100';
             end;
        end;
      Field := edtTable.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',Agio_Money);

      Field := edtTable.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney) ;
      edtTable.Post;
      edtTable.Edit;
  finally
      Locked := false;
  end;
end;

procedure TfrmOrderForm.AgioToCalc(Agio: Real);
var Agio_Rate:Real;
    Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
      if edtTable.FindField('ORG_PRICE')<>nil then
        begin
          Field := edtTable.FindField('APRICE');
          if Field<>nil then
             begin
               if Agio=0 then
                  Agio_Rate := 1
               else
                  Agio_Rate := Agio / 100;
               Field.AsString := FormatFloat('#0.000',edtTable.FindField('ORG_PRICE').AsFloat * Agio_Rate);
               Locked := false;
               PriceToCalc(Field.asFloat);
             end;
        end;
  finally
      Locked := false
  end;
end;

procedure TfrmOrderForm.AMoneyToCalc(AMoney: Real);
var AMount,APrice,Agio_Rate,Agio_Money:Real;
    Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
      Field := edtTable.FindField('AMONEY');
      if Field=nil then Exit;
      Field.AsString := FormatFloat('#0.00',AMoney);
      AMoney := Field.AsFloat;

      Field := edtTable.FindField('AMOUNT');
      if Field=nil then Exit;
      //取数量
      AMount := Field.asFloat;
      //单价
      if AMount =0 then
         APrice := 0
      else
         APrice := AMoney / AMount;
      Field := edtTable.FindField('APRICE');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.000',APrice);

      if edtTable.FindField('ORG_PRICE')=nil then
        begin
          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if Field<>nil then
             Agio_Rate := (Field.AsFloat / 100)
          else
             Agio_Rate := 1;
          //如果=0为不打折
          if Agio_Rate=0 then Agio_Rate := 1;

          Agio_Money := (AMoney/Agio_Rate ) - AMoney;
        end
      else
        begin
          if edtTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := edtTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if (Field<>nil) and (AMount<>0) then
             begin
                if edtTable.FindField('ORG_PRICE').AsFloat<>0 then
                   Field.AsString := formatFloat('#0.0',AMoney *100 /(edtTable.FindField('ORG_PRICE').AsFloat*Amount))
                else
                   Field.AsString := '100';
             end;
        end;
      Field := edtTable.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',Agio_Money);

      Field := edtTable.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney) ;
      edtTable.Post;
      edtTable.Edit;
  finally
      Locked := false
  end;
end;

procedure TfrmOrderForm.BulkToCalc(AMoney: Real);
var AMount,APrice,Agio_Rate,Agio_Money,SourceScale:currency;
    Field:TField;
    rs:TZQuery;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
      Field := edtTable.FindField('AMONEY');
      if Field=nil then Exit;
      Field.AsString := FormatFloat('#0.00',AMoney);
      AMoney := Field.AsFloat;

      Field := edtTable.FindField('APRICE');
      if Field<>nil then
         APrice := Field.AsFloat
      else
         APrice := 1;

      Field := edtTable.FindField('AMOUNT');
      if Field=nil then Exit;
      //取数量
      Field.AsString := formatFloat('#0.00',AMoney/APrice);
      Amount := Field.asFloat;
      rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
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
            Field.AsFloat := edtTable.FindField('AMOUNT').AsInteger * SourceScale;
         end;
      

      if edtTable.FindField('ORG_PRICE')=nil then
        begin
          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if Field<>nil then
             Agio_Rate := (Field.AsFloat / 100)
          else
             Agio_Rate := 1;
          //如果=0为不打折
          if Agio_Rate=0 then Agio_Rate := 1;

          Agio_Money := (AMoney/Agio_Rate ) - AMoney;
        end
      else
        begin
          if edtTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := edtTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

          //计算折扣
          Field := edtTable.FindField('AGIO_RATE');
          if (Field<>nil) and (AMount<>0) then
             begin
                if edtTable.FindField('ORG_PRICE').AsFloat<>0 then
                   Field.AsString := formatFloat('#0.0',AMoney *100 /(edtTable.FindField('ORG_PRICE').AsFloat*Amount))
                else
                   Field.AsString := '100';
             end;
        end;
      Field := edtTable.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',Agio_Money);

      Field := edtTable.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney) ;
      edtTable.Post;
      edtTable.Edit;
  finally
      Locked := false
  end;
end;

procedure TfrmOrderForm.PresentToCalc(Present: integer);
var
  Field:TField;
begin
  if edtTable.FindField('IS_PRESENT')=nil then Exit;
  edtTable.Edit;
  edtTable.FindField('IS_PRESENT').AsInteger := Present;
  Field := edtTable.FindField('APRICE');
  if Field=nil then Exit;
  if Present=1 then
     begin
       Field.AsFloat := 0;
       PriceToCalc(0);
     end
  else
     begin
       InitPrice(edtTable.FieldbyName('GODS_ID').AsString,edtTable.FieldbyName('UNIT_ID').AsString);
       PriceToCalc(edtTable.FieldbyName('APRICE').AsFloat);
     end;
  if edtTable.State in [dsInsert,dsEdit] then edtTable.Post;
  edtTable.Edit;
end;

procedure TfrmOrderForm.UnitToCalc(UNIT_ID: string);
var AMount,SourceScale:Real;
    Field:TField;
    rs:TZQuery;
    u:integer;
begin
  if Locked then Exit;
  if UNIT_ID=edtTable.FieldbyName('UNIT_ID').AsString  then Exit;
  Locked := True;
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO'); 
  try
      if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');  
      Field := edtTable.FindField('AMOUNT');
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
            edtProperty.FieldByName('IS_PRESENT').AsString := edtTable.FieldByName('IS_PRESENT').AsString;
            edtProperty.FieldByName('BATCH_NO').AsString := edtTable.FieldByName('BATCH_NO').AsString;
            edtProperty.FieldByName('UNIT_ID').AsString := UNIT_ID;
            edtProperty.FieldByName('CALC_AMOUNT').AsFloat := edtProperty.FieldByName('AMOUNT').AsFloat * SourceScale;
            edtProperty.Post;
            edtProperty.Next;
          end;
      finally
        edtProperty.Filtered := false;
      end;
      if edtTable.FindField('APRICE')<>nil then
         begin
           InitPrice(edtTable.FieldByName('GODS_ID').asString,UNIT_ID);
           Locked := false;
           AMountToCalc(AMount);
         end;
  finally
     Locked := false;
  end;
end;

function TfrmOrderForm.PropertyEnabled: boolean;
var
  rs:TZQuery;
begin
  result := false;
  Exit;
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) then
     begin
        result := not (
             ((rs.FieldbyName('SORT_ID7').AsString = '') or (rs.FieldbyName('SORT_ID7').AsString = '#'))
               and
             ((rs.FieldbyName('SORT_ID8').AsString = '') or (rs.FieldbyName('SORT_ID8').AsString = '#'))
             );
     end
  else
     Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');
end;

procedure TfrmOrderForm.AuditOrder;
begin

end;

procedure TfrmOrderForm.CancelOrder;
begin

end;

procedure TfrmOrderForm.DeleteOrder;
begin

end;

procedure TfrmOrderForm.EditOrder;
begin

end;

procedure TfrmOrderForm.NewOrder;
begin

end;

procedure TfrmOrderForm.Open(id: string);
begin

end;

procedure TfrmOrderForm.PreviewOrder;
begin

end;

procedure TfrmOrderForm.PrintOrder;
begin

end;

procedure TfrmOrderForm.SaveOrder;
begin

end;

function TfrmOrderForm.DecodeBarcode(BarCode: string): integer;
function CheckDupBar(rs:TZQuery):boolean;
var
  r:integer;
begin
  result := true;
  r := 0;
  rs.First;
  while not rs.Eof do
    begin
      if rs.FieldByName('BARCODE').AsString=BarCode then
         begin
           inc(r);
         end;
      rs.Next;
    end;
  result := (r<>1);
end;
var
  rs:TZQuery;
  AObj:TRecord_;
  r,bulk:Boolean;
  uid:string;
  amt:real;
  mny:real;
  Pri:real;
begin
  result := 2;
  if BarCode='' then Exit;
  fndStr := BarCode;
  if (BulkiFlag<>'') and (copy(BarCode,1,length(BulkiFlag))=BulkiFlag) then
     begin
       vgds := copy(BarCode,length(BulkiFlag)+1,BulkId);
       vP1 := '#';
       vP2 := '#';
       vBtNo := '#';
       amt := 0;
       mny := 0;
       Pri := 0;
       case Bulk1Flag of
       1:begin // 单价
           Pri := StrtoFloatDef(copy(Barcode,length(BulkiFlag)+BulkId+1,Bulk1Len),0);
           if Bulk1Dec in [1,2,3] then
             Pri := Pri / Power(10,Bulk1Dec)
         end;
       2:begin // 金额
           mny := StrtoFloatDef(copy(Barcode,length(BulkiFlag)+BulkId+1,Bulk1Len),0);
           if Bulk1Dec in [1,2,3] then
             mny := mny / Power(10,Bulk1Dec)
         end;
       3:begin // 数量
           amt := StrtoFloatDef(copy(Barcode,length(BulkiFlag)+BulkId+1,Bulk1Len),0);
           if Bulk1Dec in [1,2,3] then
             amt := amt / Power(10,Bulk1Dec)
         end;
       end;
       case Bulk2Flag of
       1:begin // 单价
           Pri := StrtoFloatDef(copy(Barcode,length(BulkiFlag)+BulkId+Bulk1Len+1,Bulk2Len),0);
           if Bulk2Dec in [1,2,3] then
             Pri := Pri / Power(10,Bulk2Dec)
         end;
       2:begin // 金额
           mny := StrtoFloatDef(copy(Barcode,length(BulkiFlag)+BulkId+Bulk1Len+1,Bulk2Len),0);
           if Bulk2Dec in [1,2,3] then
             mny := mny / Power(10,Bulk2Dec)
         end;
       3:begin // 数量
           amt := StrtoFloatDef(copy(Barcode,length(BulkiFlag)+BulkId+Bulk1Len+1,Bulk2Len),0);
           if Bulk2Dec in [1,2,3] then
             amt := amt / Power(10,Bulk2Dec)
         end;
       end;
       bulk := true;
     end
  else
  begin
    rs := TZQuery.Create(nil);
    AObj := TRecord_.Create;
    try
      if not dllGlobal.GetGodsFromBarcode(rs,fndStr) then
        begin
          if not dllGlobal.GetGodsFromGodsCode(rs,fndStr) then Exit;
          if (rs.RecordCount > 1) and not TfrmFindDialog.FindDSDialog(rs,AObj,'GODS_CODE=货号,GODS_NAME=商品名称,NEW_OUTPRICE=标准售价') then
             begin
               fndStr := '';
               result := 3;
               Exit;
             end
          else
             begin
               vgds := rs.FieldbyName('GODS_ID').AsString;
               vP1  := '#';
               vP2  := '#';
               vBtNo := '#';
               uid := rs.FieldbyName('UNIT_ID').asString;
             end;
           end
        else
           begin
              if (rs.RecordCount > 1) and CheckDupBar(RS) then
                 begin
                    fndStr := '';
                    rs.first;
                    while not rs.eof do
                      begin
                        if fndStr<>'' then fndStr := fndStr+',';
                        fndStr := fndStr + ''''+rs.FieldbyName('GODS_ID').asString+'''';
                        rs.next;
                      end;
                    if not TfrmFindDialog.FindSQLDialog('select GODS_ID,GODS_CODE,GODS_NAME,NEW_OUTPRICE from VIW_GOODSINFO where TENANT_ID='+token.tenantId+' and GODS_ID in ('+fndStr+') and COMM not in (''02'',''12'')',AObj,'GODS_CODE=货号,GODS_NAME=商品名称,NEW_OUTPRICE=标准售价') then
                       begin
                         fndStr := '';
                         result := 3;
                         Exit;
                       end
                    else
                       rs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]);
                 end;
              if result <> 3 then
                 begin
                   vgds := rs.FieldbyName('GODS_ID').AsString;
                   vP1 := rs.FieldbyName('PROPERTY_01').AsString;
                   vP2 := rs.FieldbyName('PROPERTY_02').AsString;
                   if vP1='' then vP1 := '#';
                   if vP2='' then vP2 := '#';
                   uid := rs.FieldbyName('UNIT_ID').AsString;
                   vBtNo := rs.FieldbyName('BATCH_NO').AsString;
                 end;
         end;
    finally
      rs.Free;
      AObj.free;
    end;
  end;

  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  AObj := TRecord_.Create;
  try
    if bulk then
       begin
         if rs.Locate('GODS_CODE',vgds,[]) then
            AObj.ReadFromDataSet(rs)
         else
            Exit;
         uid := rs.FieldbyName('CALC_UNITS').asString;
       end
    else
       begin
         if rs.Locate('GODS_ID',vgds,[]) then
            AObj.ReadFromDataSet(rs)
         else
            Exit;
       end;
    result := 0;
    AddRecord(AObj,uid);
    if AObj.FieldbyName('GODS_ID').asString=edtTable.FieldbyName('GODS_ID').asString then
    begin
      edtTable.Edit;
      edtTable.FieldbyName('BATCH_NO').AsString := vBtNo;
      if not Bulk then
         WriteAmount(uid,vP1,vP2,1,true)
      else
         BulkAmount(uid,amt,pri,mny,true);
    end;
  finally
    AObj.Free;
  end;
  if result=0 then MessageBeep(0);
end;

procedure TfrmOrderForm.BulkAmount(UNIT_ID: string; Amt, Pri, mny: real;
  Appended: boolean);
begin
   if PropertyEnabled then Raise Exception.Create('散装商品不支持带颜色及尺码属性的商品...');
   if edtTable.FieldbyName('UNIT_ID').AsString <> UNIT_ID then Raise Exception.Create('散装商品不支持多单位转换...');
   if Pri<>0 then
      begin
        if (edtTable.FindField('APRICE')<>nil) then
           begin
             edtTable.FieldbyName('APRICE').AsFloat := Pri;
           end;
      end;
   if amt<>0 then
      begin
        if (edtTable.FindField('AMOUNT')<>nil) then
           begin
             if Appended then
                edtTable.FieldbyName('AMOUNT').AsFloat := edtTable.FieldbyName('AMOUNT').AsFloat+amt
             else
                edtTable.FieldbyName('AMOUNT').AsFloat := amt;
             AMountToCalc(edtTable.FieldbyName('AMOUNT').AsFloat);
           end;
      end;
   if mny<>0 then
      begin
        if (edtTable.FindField('AMONEY')<>nil) then
           begin
             if Appended then
                edtTable.FieldbyName('AMONEY').AsFloat := edtTable.FieldbyName('AMONEY').AsFloat + mny
             else
                edtTable.FieldbyName('AMONEY').AsFloat := mny;
             BulkToCalc(edtTable.FieldbyName('AMONEY').AsFloat);
           end;
      end;
end;

procedure TfrmOrderForm.WriteAmount(UNIT_ID, PROPERTY_01,
  PROPERTY_02: string; Amt: real; Appended: boolean);
var b:boolean;
begin
  b := PropertyEnabled;
  if b and ((PROPERTY_01='#') and (PROPERTY_02='#')) then
     begin
       PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,0);
       Exit;
     end;
  if (edtTable.FindField('AMOUNT')<>nil) then
  begin
    if not b then
    begin
      edtTable.Edit;
      if Appended then
         edtTable.FieldbyName('AMOUNT').AsFloat := edtTable.FieldbyName('AMOUNT').AsFloat + amt
      else
         edtTable.FieldbyName('AMOUNT').AsFloat := amt;
    end;
  end
  else
    Raise Exception.Create('AMOUNT字段没找到');
  if b then
     begin
       if edtProperty.Locate('SEQNO;PROPERTY_01;PROPERTY_02',VarArrayOf([edtTable.FieldbyName('SEQNO').AsInteger,PROPERTY_01,PROPERTY_02]),[]) then
         begin
           edtProperty.Edit;
           edtTable.Edit;
           if Appended then
              edtTable.FieldbyName('AMOUNT').AsFloat := edtTable.FieldbyName('AMOUNT').AsFloat + amt
           else
              edtTable.FieldbyName('AMOUNT').AsFloat := edtTable.FieldbyName('AMOUNT').AsFloat - edtProperty.FieldbyName('AMOUNT').AsFloat + amt;
         end else
         begin
           edtProperty.Append;
           edtTable.Edit;
           edtTable.FieldbyName('AMOUNT').AsFloat := edtTable.FieldbyName('AMOUNT').AsFloat + amt
         end;
       edtProperty.FieldByName('SEQNO').AsInteger := edtTable.FieldbyName('SEQNO').AsInteger;
       edtProperty.FieldByName('GODS_ID').AsString := edtTable.FieldbyName('GODS_ID').AsString;
       edtProperty.FieldByName('BOM_ID').AsString := edtTable.FieldbyName('BOM_ID').AsString;
       edtProperty.FieldByName('BATCH_NO').AsString := edtTable.FieldbyName('BATCH_NO').AsString;
       edtProperty.FieldByName('IS_PRESENT').AsString := edtTable.FieldbyName('IS_PRESENT').AsString;
       edtProperty.FieldByName('LOCUS_NO').AsString := edtTable.FieldbyName('LOCUS_NO').AsString;
       edtProperty.FieldByName('UNIT_ID').AsString := UNIT_ID;
       edtProperty.FieldByName('PROPERTY_01').AsString := PROPERTY_01;
       edtProperty.FieldByName('PROPERTY_02').AsString := PROPERTY_02;
       if Appended then
          edtProperty.FieldbyName('AMOUNT').AsFloat := edtProperty.FieldbyName('AMOUNT').AsFloat + amt
       else
          edtProperty.FieldbyName('AMOUNT').AsFloat := amt;
       edtProperty.Post;
     end;
  AMountToCalc(edtTable.FieldbyName('AMOUNT').AsFloat);
  edtTable.Post;
end;

procedure TfrmOrderForm.edtInputKeyPress(Sender: TObject; var Key: Char);
var
  s:string;
  IsNumber,IsFind,isAdd:Boolean;
  amt:Real;
  AObj:TRecord_;
begin
  inherited;
  try
  if Key=#13 then
    begin
      if (dbState = dsBrowse) then Exit;
      s := trim(edtInput.Text);
      edtInput.SelectAll;
      if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
      Key := #0;
      try
      if InputFlag=1 then //会员卡号
         begin
           WriteInfo(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           edtInput.Text := '';
           Exit;
         end;
      if InputFlag=2 then //整单折扣
         begin
           if s<>'' then AgioInfo(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           edtInput.Text := '';
           Exit;
         end;
      if InputFlag=3 then //单价
         begin
           if s<>'' then PriceToGods(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           edtInput.Text := '';
           Exit;
         end;
      if InputFlag=4 then //折扣率
         begin
           if s<>'' then AgioToGods(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           edtInput.Text := '';
           Exit;
         end;
      if InputFlag=5 then //单位
         begin
           InputFlag := 0;
           DBGridEh1.Col := 1;
           edtInput.Text := '';
           Exit;
         end;
      if InputFlag=6 then //赠品
         begin
           InputFlag := 0;
           DBGridEh1.Col := 1;
           edtInput.Text := '';
           Exit;
         end;
      if InputFlag=9 then //数量输入
         begin
           if s<>'' then GodsToAmount(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           edtInput.Text := '';
           Exit;
         end;
      isAdd := false;
      if s='' then
         begin
           fndStr := '';
           Exit;
         end;
      IsNumber := false;
      if s[1]='+' then
         begin
            Delete(s,1,1);
            isAdd := true;
         end ;
      if ((length(s) in [1,2,3,4]) and FnString.IsNumberChar(s)) or IsNumber then
         begin
             if trim(s)='' then Exit;
             if edtTable.FieldbyName('GODS_ID').asString='' then Exit;
             if not IsNumber then amt := StrtoFloatDef(s,0);
             if amt=0 then
                begin
                   AObj := TRecord_.Create;
                   try
                      AObj.ReadFromDataSet(edtTable);
                      DelRecord(AObj)
                   finally
                      AObj.Free;
                   end;
                end
             else
                begin
                  if PropertyEnabled then
                     begin
                       if (vgds = edtTable.FieldbyName('GODS_ID').AsString) and ((vP1<>'#') or (vP2<>'#')) then
                         WriteAmount(edtTable.FieldbyName('UNIT_ID').AsString,vP1,vP2,amt,isAdd)
                       else
                         PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,0);
                     end
                  else
                     begin
                       WriteAmount(edtTable.FieldbyName('UNIT_ID').AsString,'#','#',amt,isAdd);
                     end;
                end;
            edtInput.Text := '';
         end
      else
         begin
           case DecodeBarCode(trim(s)) of
             2:begin
                 MessageBox(Handle,'输入的条码无效..','友情提示...',MB_OK+MB_ICONQUESTION);
               end;
             3:begin
                 edtInput.Text := '';
                 Exit;
               end;
           else
              edtInput.Text := '';
           end;
         end;
      except
         edtInput.SelectAll;
         Raise;
      end;
    end;

    if Key='-' then
      begin
        if MessageBox(Handle,pchar('是否删除当前选择商品"'+edtTable.FieldbyName('GODS_NAME').asString+'"'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
        AObj := TRecord_.Create;
        try
           AObj.ReadFromDataSet(edtTable);
           DelRecord(AObj)
        finally
           AObj.Free;
        end;
        Key := #0;
      end;
  finally
     if edtInput.CanFocus and not edtInput.Focused then
        if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
  end;
end;

procedure TfrmOrderForm.AgioInfo(id: string);
begin

end;

procedure TfrmOrderForm.AgioToGods(id: string);
begin

end;

function TfrmOrderForm.CheckInput: boolean;
begin
  result := true;
end;

procedure TfrmOrderForm.GodsToAmount(id: string);
begin

end;

function TfrmOrderForm.GodsToBatchNo(id: string): boolean;
begin

end;

function TfrmOrderForm.GodsToLocusNo(id: string): boolean;
begin

end;

procedure TfrmOrderForm.PriceToGods(id: string);
begin

end;

procedure TfrmOrderForm.WriteInfo(id: string);
begin

end;

procedure TfrmOrderForm.fndGODS_IDSaveValue(Sender: TObject);
var AObj:TRecord_;
  rs:TZQuery;
  pt:boolean;
begin
  inherited;
  if not edtTable.Active then Exit;
  if edtTable.FieldbyName('GODS_ID').AsString=fndGODS_ID.AsString then exit;
  edtTable.DisableControls;
  try
  if edtTable.FieldbyName('GODS_ID').AsString <> '' then
     begin
       if edtTable.FieldByName('BOM_ID').AsString = '' then
       begin
         if MessageBox(Handle,pchar('是否把当前选中商品修改为"'+fndGODS_ID.Text+'('+fndGODS_ID.DataSet.FieldbyName('GODS_CODE').AsString+')"？'),'友情提示',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then
            begin
              fndGODS_ID.Text := edtTable.FieldbyName('GODS_NAME').AsString;
              fndGODS_ID.KeyValue := edtTable.FieldbyName('GODS_ID').AsString;
              Exit;
            end;
       end
       else
       begin
          MessageBox(Handle,pchar('礼盒包装不能单商品修改，请删除重新扫码'),'友情提示',MB_OK+MB_ICONINFORMATION);
          fndGODS_ID.Text := edtTable.FieldbyName('GODS_NAME').AsString;
          fndGODS_ID.KeyValue := edtTable.FieldbyName('GODS_ID').AsString;
          Exit;
       end;
     end;
  if VarIsNull(fndGODS_ID.KeyValue) then
  begin
    EraseRecord;
  end
  else
  begin
    AObj := TRecord_.Create;
    try
      rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
      if rs.Locate('GODS_ID',fndGODS_ID.AsString,[]) then
      begin
        AObj.ReadField(edtTable);
        AObj.ReadFromDataSet(rs,false);
        AObj.FieldbyName('UNIT_ID').AsString := rs.FieldbyName('UNIT_ID').AsString;
        AObj.FieldbyName('IS_PRESENT').AsInteger := 0;
        AObj.FieldbyName('LOCUS_NO').AsString := '';
        AObj.FieldbyName('BATCH_NO').AsString := '#';

        if CheckRepeat(AObj) then
           begin
             fndGODS_ID.Text := edtTable.FieldbyName('GODS_NAME').AsString;
             fndGODS_ID.KeyValue := edtTable.FieldbyName('GODS_ID').AsString;
             Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.GoodsRepeat','"%s"货品重复录入,请核对输入是否正确.',[edtTable.FieldbyName('GODS_NAME').AsString]));
           end;
           
        UpdateRecord(AObj,edtTable.FieldByName('UNIT_ID').AsString);
      end
      else
        Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.NoFindGoodsInfo','在经营品牌中没找到"%s"',[fndGODS_ID.Text]));
    finally
      AObj.Free;
    end;
    if (edtTable.FindField('AMOUNT')<>nil) and (edtTable.FindField('AMOUNT').AsFloat=0) then
       begin
         if not PropertyEnabled then
            begin
              edtTable.FieldbyName('AMOUNT').AsFloat := 1;
              AMountToCalc(1);
            end
         else
            PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,0);
       end;
  end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    edtTable.EnableControls;
  end;
end;

function TfrmOrderForm.CheckRepeat(AObj: TRecord_): boolean;
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
           (edtTable.FieldbyName('IS_PRESENT').AsString = AObj.FieldbyName('IS_PRESENT').AsString)
           and
           (edtTable.FieldbyName('UNIT_ID').AsString = AObj.FieldbyName('UNIT_ID').AsString)
           and
           (edtTable.FieldbyName('LOCUS_NO').AsString = AObj.FieldbyName('LOCUS_NO').AsString)
           and
           (edtTable.FieldbyName('BATCH_NO').AsString = AObj.FieldbyName('BATCH_NO').AsString)
           and
           (edtTable.FieldbyName('BOM_ID').AsString = AObj.FieldbyName('BOM_ID').AsString)
           and
           (edtTable.FieldbyName('SEQNO').AsInteger <> r)
        then
           begin
              inc(c);
              break;
           end;
        edtTable.Next;
      end;
    if c>0 then
      begin
        if (MessageBox(Handle,pchar('"'+AObj.FieldbyName('GODS_NAME').asString+'('+AObj.FieldbyName('GODS_CODE').asString+')已经存在，是否继续添加赠品？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)=6) then
           result := false else result := true;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
end;

procedure TfrmOrderForm.DBGridEh1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
begin
  inherited;
  Cell := DBGridEh1.MouseCoord(X,Y);
  if Cell.Y > DBGridEh1.VisibleRowCount -2 then
     InitRecord;
end;

end.
