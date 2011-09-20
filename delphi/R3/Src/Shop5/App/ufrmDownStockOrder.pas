{ 到货物确认：
  (1)、供应商: 是烟草公司;
  (2)、订单一天只有一单，若存在多单情况则进行合并为一张。

}


unit ufrmDownStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, DB, 
  ExtCtrls, RzPanel, DBClient, Grids, DBGridEh, cxButtonEdit, zrComboBoxList,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, zBase, DBGrids, Buttons;

type
  TfrmDownStockOrder = class(TfrmBasic)
    RzPanel1: TRzPanel;
    Ds: TDataSource;
    cdsTable: TZQuery;
    TitlePanel: TPanel;
    LblMsg: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    BottonPanel: TPanel;
    Bevel1: TBevel;
    btnOK: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    CdsStockData: TZQuery;
    LblCount: TLabel;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FXsm: boolean;
    procedure SetINDEOrderMsg; //设置记录信息
    function CheckIsOrderDown: Boolean; //判断本地是否已下载过
    function FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    function GetOrderDate: TDate;
    function GetINDE_ID: string;

    //下载订单后自动完成入库
    procedure AmountToCalc(edtTable: TDataSet; Amount: Real);  //计算
    function  IndeOrderWriteToStock(AObj: TRecord_; vData: OleVariant): Boolean;
    procedure SetXsm(const Value: boolean); //入库1单
    procedure DoXsmAutoStockOrder; //新商盟自动入库
  public
    FAobj: TRecord_;
    FReData: OleVariant; //返回数据包
    procedure OpenIndeOrderList(DownType: integer=0);  //查询订单主表数据
    procedure DoCopyIndeOrderData;    //将选中的订单明细处理到中间表
    class function DownStockOrder(var Aobj: TRecord_;var vData: Olevariant):boolean;
    class function AutoDownStockOrder(const IndeDate: string):Boolean; //自动到货确认[IndeDate='YYYYMMDD']
    class function XsmShow:boolean;
    property OrderDate: TDate read GetOrderDate;
    property Xsm:boolean read FXsm write SetXsm;
  end;


implementation

uses
  uFnUtil, uDsUtil, ZLogFile, uGlobal, uShopGlobal,uSyncFactory;  //ufrmCallIntf,

{$R *.dfm}

{ TfrmDownStockOrder }

{ 订单日期：IndeDate 如：20110527 }
class function TfrmDownStockOrder.AutoDownStockOrder(const IndeDate: string):Boolean; //自动到货确认
var
  MsgStr,ErrMsg: string;
begin
  Result:=False;
  MsgStr:='';
  ErrMsg:='';
  with TfrmDownStockOrder.Create(nil) do
  begin
    try
      FAobj:=TRecord_.Create;
      //1、调用原取Orade列表过程，返回近30天订单
      OpenIndeOrderList(1);  //查询订单主表数据
      if cdsTable.IsEmpty then
      begin
        LogFile.AddLogFile(0,'自动下载订单<没有订单>');  //自动订单写日志
        exit;   //没有订单List就不退出
      end;
      //2、循环订单入库
      cdsTable.First;
      while not cdsTable.Eof do
      begin
        if cdsTable.FieldByName('INDE_DATE').AsString=IndeDate then  //指定日期下载
        begin
          try
            if CheckIsOrderDown=False then //检查还没入库继续入库
            begin
              DoCopyIndeOrderData;   //复制订单明细数据
              FAobj.ReadFromDataSet(cdsTable);  //读取返回值
              IndeOrderWriteToStock(FAobj, FReData); //保存入库
              if cdsTable.FindField('INDE_ID')<>nil then
              begin
                if MsgStr='' then MsgStr:=cdsTable.FindField('INDE_ID').AsString
                else MsgStr:=MsgStr+','+cdsTable.FindField('INDE_ID').AsString;
              end;
            end else
            begin
              if cdsTable.FindField('INDE_ID')<>nil then
              begin
                if ErrMsg='' then ErrMsg:=cdsTable.FindField('INDE_ID').AsString
                else ErrMsg:=ErrMsg+','+cdsTable.FindField('INDE_ID').AsString;
              end;
            end;
            //自动订单写日志:
            if MsgStr<>'' then LogFile.AddLogFile(0,'自动下载订单<下载成功:'+MsgStr+'; 检测到入库：'+ErrMsg+'>');
          except
            MessageBox(Handle,pchar('自动接收订单失败，请手工执行！'),'友情提示...',MB_OK+MB_ICONWARNING);
          end;
        end;
        cdsTable.Next;
      end;
    finally
      FAobj.Free;
      Free;
    end;
  end;
end;


class function TfrmDownStockOrder.DownStockOrder(var Aobj: TRecord_;var vData: Olevariant):boolean;
var
  FrmObj: TfrmDownStockOrder;
begin
  Result:=False;
  try
    FrmObj:=TfrmDownStockOrder.Create(nil);
    FrmObj.FAobj:=Aobj;
    FrmObj.OpenIndeOrderList;  //查询订单的主表数据
    if FrmObj.ShowModal=MROK then
    begin
      vData:=FrmObj.FReData;
      result:=true;
    end;
  finally
    FrmObj.Free;
  end;
end;

procedure TfrmDownStockOrder.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDownStockOrder.btnOKClick(Sender: TObject);
begin
  inherited;
  //2011.09.20Add 判断到货是否为锁定电脑
  if not SyncFactory.SyncLockCheck then Raise Exception.Create('  非本门店的专用电脑不能做到货确认！ ');

  if not Xsm then //手工确认
  begin
    if not ShopGlobal.GetChkRight('11200001',2) then Raise Exception.Create('你没有权限操作到货确认（生成入库单！）');
    if cdsTable.IsEmpty then Raise Exception.Create(' 没有订单！ ');
    if trim(CdsTable.fieldbyName('INDE_ID').AsString)<>'' then
     begin
      //2011.05.10 Add判断是否本地已下载过
      if CheckIsOrderDown then
      begin
        cdsTable.Delete;
        SetINDEOrderMsg;  //显示订单数
        Raise Exception.Create('当前订单：'+CdsTable.fieldbyName('INDE_ID').AsString+'已本地下载不能重复下载！');
      end;

      DoCopyIndeOrderData;  //复制明细数据
      FAobj.ReadFromDataSet(cdsTable);  //读取返回值
      ModalResult:=MROK; //正常返回
    end;
  end else
  begin  //新商盟登陆
    DoXsmAutoStockOrder;
  end;
end;

procedure TfrmDownStockOrder.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if cdsTable.RecNo = 1 then AFont.Style := [fsBold];
end;

procedure TfrmDownStockOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    DBGridEh1.Canvas.Font.Style :=[fsBold];
    DBGridEh1.Canvas.Brush.Color := clAqua;   //选中颜色状态
  end else
    DBGridEh1.Canvas.Font.Style :=[];

  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DBGridEh1.canvas.Brush.Color := $0000F2F2;
    DBGridEh1.canvas.FillRect(ARect);
    DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

function TfrmDownStockOrder.GetOrderDate: TDate;
begin
  if cdsTable.Active then
    fnTime.fnStrtoDate(cdsTable.fieldbyName('CRT_DATE').AsString);
end;

function TfrmDownStockOrder.GetINDE_ID: string;
begin
  if cdsTable.Active then
    result:=trim(CdsTable.fieldbyName('INDE_ID').AsString);
end;

//下载类型:
procedure TfrmDownStockOrder.OpenIndeOrderList(DownType: integer);
var
  whereCnd, UseDate,Arr_Day,OrderStatus: string; //启用日期,到达日期
  Rs: TZQuery;
  vParam: TftParamList;
begin
  try
    //启用日期
    Rs:=Global.GetZQueryFromName('SYS_DEFINE');
    if (Rs<>nil) and (Rs.Active) then
    begin
      if Rs.Locate('DEFINE','USING_DATE', []) then
      begin
        UseDate:=trim(Rs.fieldbyName('VALUE').AsString);
        UseDate:=FormatDateTime('YYYYMMDD', fnTime.fnStrtoDate(UseDate));
      end else
        UseDate:=FormatDateTime('YYYYMMDD', Date()); //默认今天
    end;

    Rs:=TZQuery.Create(nil);
    vParam:=TftParamList.Create(nil);
    vParam.ParamByName('ExeType').AsInteger:=1;
    vParam.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    vParam.ParamByName('SHOP_ID').AsString:=Global.SHOP_ID;
    vParam.ParamByName('USING_DATE').AsString:=UseDate;
    Global.RemoteFactory.Open(CdsTable,'TDownOrder',vParam);  //==RspServer连接模式时执行
    //根据取出单据号。过滤查询本地库
    if not CdsTable.IsEmpty then //有订单与本地对比
    begin
      whereCnd:='';
      CdsTable.First;
      while not CdsTable.Eof do
      begin
        if whereCnd='' then
          whereCnd:=''''+CdsTable.fieldbyName('INDE_ID').AsString+''' ' 
        else
          whereCnd:=whereCnd+','''+CdsTable.fieldbyName('INDE_ID').AsString+''' ';
        CdsTable.Next;
      end;

      Rs.Close;
      Rs.SQL.Text:='select COMM_ID from STK_STOCKORDER where COMM_ID in ('+whereCnd+') ';
      Factor.Open(Rs);
      Rs.First;
      while not Rs.Eof do
      begin
        if CdsTable.Locate('INDE_ID',trim(Rs.fieldbyName('COMM_ID').AsString),[]) then
           CdsTable.Delete;
      Rs.Next;
      end;

      //2011.08.25 Add过滤到货日期小于启用日期：
      CdsTable.First;
      while not CdsTable.Eof do
      begin
        Arr_Day:=trim(CdsTable.FieldByName('ARR_DATE').AsString);
        if (Arr_Day<>'') and (Arr_Day < UseDate) then  //到货日期不为空，并且小于启用日期过滤掉
          CdsTable.Delete
        else
          CdsTable.Next; 
      end;
      //过滤掉状态为:
      if DownType=1 then
      begin
        CdsTable.First;
        while not CdsTable.Eof do
        begin
          OrderStatus:=trim(CdsTable.FieldByName('STATUS').AsString);
          if (OrderStatus='05') or (OrderStatus='06') then  //不是0
            CdsTable.Next 
          else
            CdsTable.Delete;
        end;
      end;
    end;
    CdsTable.First;
    SetINDEOrderMsg; //显示订单数
  finally
    CdsTable.EnableControls;
    vParam.Free;
    Rs.Free;
  end;
end;

procedure TfrmDownStockOrder.DoCopyIndeOrderData;
var
  i: integer;
  Msg,Str: String;
  vParam: TftParamList;
begin
  i:=0;
  try                              
    CdsStockData.Close;
    vParam:=TftParamList.Create(nil);
    vParam.ParamByName('ExeType').AsInteger:=2;
    vParam.ParamByName('INDE_ID').AsString:=GetINDE_ID;
    vParam.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    Global.RemoteFactory.Open(CdsStockData,'TDownIndeData',vParam);  //==RspServer连接模式时执行
    if (CdsStockData.Active) and (CdsStockData.RecordCount>0) then
    begin
      Msg:='';
      CdsStockData.First;
      while not CdsStockData.Eof do
      begin
        if trim(CdsStockData.FieldByName('GODS_ID').AsString)='' then
          Inc(i);
        CdsStockData.Next; 
      end;
      if i>0 then
      begin
        Str:='系统检测到当前下载的订单,有'+inttoStr(i)+'个新品！';
        Raise Exception.Create(Str);
      end;
      FReData:=CdsStockData.Data;
    end;
  finally
    vParam.Free;
  end;
end;
 

function TfrmDownStockOrder.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[i].FieldName = FieldName then
    begin
      result := DBGrid.Columns[i];
      Exit;
    end;
  end;
end;

procedure TfrmDownStockOrder.FormCreate(Sender: TObject);
var
  Rs: TZQuery;
  SetCol: TColumnEh;
begin
  inherited;
  Xsm := false;
  Rs:=Global.GetZQueryFromName('CA_TENANT'); 
  SetCol:=FindColumn(DBGridEh1,'TENANT_ID');
  if (SetCol<>nil) and (Rs.Active) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    Rs.First;
    while not Rs.Eof do
    begin
      SetCol.KeyList.Add(trim(Rs.FieldByName('TENANT_ID').AsString));
      SetCol.PickList.Add(trim(Rs.FieldByName('TENANT_NAME').AsString));  
      Rs.Next;
    end;
  end;
end;

function TfrmDownStockOrder.CheckIsOrderDown: Boolean;
var
  Rs: TZQuery;
  Str,IndeID: string;
begin
  result:=False;
  IndeID:=trim(CdsTable.fieldbyName('INDE_ID').AsString);
  Str:='select Count(*) as ReSum from STK_STOCKORDER where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and COMM_ID='''+IndeID+''' ';
  try
    Rs:=TZQuery.Create(nil);
    Rs.Close;
    Rs.SQL.Text:=Str;
    Factor.Open(Rs);
    if Rs.FieldByName('ReSum').AsInteger>0 then
      result:=true;
  finally
    Rs.Free;
  end;
end;

function TfrmDownStockOrder.IndeOrderWriteToStock(AObj: TRecord_; vData: OleVariant): Boolean;
  function GetDeptID: string;
  var Rs: TZQuery;
  begin
    result:='';
    Rs:=ShopGlobal.GetDeptInfo;
    if Rs<>nil then
      result:=Rs.fieldbyname('DEPT_ID').AsString;
  end;
var
  i,DefInvIdx: integer;
  mny,amt: real;
  TenantID,ShopID,CurName: string;
  Params:TftParamList;
  Rs, RsGods, RsUnit,cdsHeader,cdsDetail: TZQuery;
begin
  result:=False;
  mny:=0;
  amt:=0;
  try
    Rs:=TZQuery.Create(nil);
    cdsHeader:=TZQuery.Create(nil);
    cdsDetail:=TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Params.ParamByName('STOCK_ID').asString :='';
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TStockOrder',Params);
      Factor.AddBatch(cdsDetail,'TStockData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    //默认票据类型、税率
    DefInvIdx:=StrtoIntDef(ShopGlobal.GetParameter('IN_INV_FLAG'),1);
    
    //写入表头数据
    cdsHeader.Edit;
    cdsHeader.FieldByName('STOCK_ID').AsString:=TSequence.NewId();
    cdsHeader.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsHeader.FieldbyName('SHOP_ID').AsString := Aobj.FieldbyName('SHOP_ID').AsString;
    cdsHeader.FieldByName('STOCK_TYPE').AsInteger := 1;
    cdsHeader.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    cdsHeader.FieldByName('CREA_USER').AsString := Global.UserID;   //操作员
    cdsHeader.FieldByName('GUIDE_USER').AsString :=Global.UserID;   //收货人
    cdsHeader.FieldByName('CLIENT_ID').AsString := Aobj.FieldbyName('CLIENT_ID').AsString; //烟草公司ID
    cdsHeader.FieldByName('STOCK_DATE').AsString :=AObj.fieldbyName('INDE_DATE').AsString; //订单日期;
    cdsHeader.FieldByName('STOCK_DATE').AsString :=AObj.fieldbyName('INDE_DATE').AsString; //订单日期;
    cdsHeader.FieldByName('COMM_ID').AsString := Aobj.FieldbyName('INDE_ID').AsString;     //订单号
    cdsHeader.FieldByName('DEPT_ID').AsString := GetDeptID;     //默认部门
    cdsHeader.FieldByName('INVOICE_FLAG').AsString :=inttostr(DefInvIdx);  //票据类型
    case DefInvIdx of                                                      //税率  
     1: cdsHeader.FieldByName('TAX_RATE').AsFloat := 0;
     2: cdsHeader.FieldByName('TAX_RATE').AsFloat := StrtoFloatDef(ShopGlobal.GetParameter('IN_RATE2'),0.05);
     3: cdsHeader.FieldByName('TAX_RATE').AsFloat := StrtoFloatDef(ShopGlobal.GetParameter('IN_RATE3'),0.17);   
    end;
    cdsHeader.Post;

    if ShopGlobal.GetParameter('STK_AUTO_CHK')<>'0' then
    begin
      cdsHeader.Edit;
      cdsHeader.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
      cdsHeader.FieldbyName('CHK_USER').AsString := Global.UserID;
      cdsHeader.Post;
    end;
    //写入表体数据
    Rs.Data:=vData;
    RsGods := Global.GetZQueryFromName('PUB_GOODSINFO');
    RsUnit := Global.GetZQueryFromName('PUB_MEAUNITS');

    cdsDetail.IndexFieldNames:='SEQNO';
    cdsDetail.SortedFields:='SEQNO';
    Rs.First;
    while not Rs.Eof do
    begin
      if cdsDetail.IsEmpty then cdsDetail.Edit else cdsDetail.Append;
      cdsDetail.FieldByName('STOCK_ID').AsString:=cdsHeader.FieldByName('STOCK_ID').AsString;
      cdsDetail.FieldByName('TENANT_ID').AsString:=cdsHeader.FieldByName('TENANT_ID').AsString;
      cdsDetail.FieldByName('SHOP_ID').AsString:=cdsHeader.FieldByName('SHOP_ID').AsString;
      cdsDetail.FieldbyName('SEQNO').AsInteger := Rs.RecNo;
      cdsDetail.FieldbyName('GODS_ID').AsString := Rs.FieldbyName('GODS_ID').AsString;
      if RsGods.Locate('GODS_ID',Rs.FieldbyName('GODS_ID').AsString,[]) then
      begin
        cdsDetail.FieldbyName('GODS_NAME').AsString := RsGods.FieldbyName('GODS_NAME').AsString;
        cdsDetail.FieldbyName('GODS_CODE').AsString := RsGods.FieldbyName('GODS_CODE').AsString;
        // cdsDetail.FieldbyName('BARCODE').AsString := RsGods.FieldbyName('BARCODE').AsString;
        //零售价: ORG_PRICE
        if trim(Rs.FieldByName('UNIT_ID').AsString)=trim(RsGods.FieldByName('SMALL_UNITS').AsString) then //小件单位
          cdsDetail.FieldbyName('ORG_PRICE').AsFloat :=RsGods.FieldbyName('NEW_OUTPRICE1').AsFloat
        else if trim(Rs.FieldByName('UNIT_ID').AsString)=trim(RsGods.FieldByName('BIG_UNITS').AsString) then     //大件单位
          cdsDetail.FieldbyName('ORG_PRICE').AsFloat :=RsGods.FieldbyName('NEW_OUTPRICE2').AsFloat
        else
          cdsDetail.FieldbyName('ORG_PRICE').AsFloat := RsGods.FieldbyName('NEW_OUTPRICE').AsFloat;
      end else
      begin
        cdsDetail.Close;
        cdsDetail.CreateDataSet;
        Exit; // 退出
      end;
      //单位换算:
      cdsDetail.FieldbyName('UNIT_ID').AsString := Rs.FieldbyName('UNIT_ID').AsString;
      // UnitToCalc(cdsDetail.FieldbyName('UNIT_ID').AsString);

      cdsDetail.FieldbyName('AMOUNT').AsFloat := Rs.FieldbyName('AMOUNT').AsFloat;   //数量
      cdsDetail.FieldbyName('AMONEY').AsFloat := Rs.FieldbyName('AMONEY').AsFloat;   //金额
      cdsDetail.FieldbyName('AGIO_MONEY').AsFloat := Rs.FieldbyName('AGIO_MONEY').AsFloat;  //折扣（让利）金额
      if Rs.FieldbyName('AMOUNT').AsFloat<>0 then
        cdsDetail.FieldbyName('APRICE').AsString := formatFloat('#0.000', Rs.FieldbyName('AMONEY').AsFloat / Rs.FieldbyName('AMOUNT').AsFloat);

      AMountToCalc(cdsDetail, cdsDetail.FieldbyName('AMOUNT').AsFloat);
      cdsDetail.FieldbyName('REMARK').AsString := '';
      if Rs.FieldbyName('NEED_AMT').AsFloat<>0 then
         cdsDetail.FieldbyName('REMARK').AsString := '需求量:'+Rs.FieldbyName('NEED_AMT').AsString;
      if Rs.FieldbyName('CHK_AMT').AsFloat<>0 then
         cdsDetail.FieldbyName('REMARK').AsString := cdsDetail.FieldbyName('REMARK').AsString+'审核量:'+Rs.FieldbyName('CHK_AMT').AsString;
      //计算累计数
      mny := mny + cdsDetail.FieldbyName('CALC_MONEY').asFloat;
      amt := amt + cdsDetail.FieldbyName('AMOUNT').asFloat;

      //处理不为空字段:
      cdsDetail.FieldbyName('BATCH_NO').AsString:='#';
      cdsDetail.FieldbyName('PROPERTY_01').AsString:='#';
      cdsDetail.FieldbyName('PROPERTY_02').AsString:='#';
      cdsDetail.FieldbyName('IS_PRESENT').AsInteger:=0;
      cdsDetail.Post;
      Rs.Next;
    end;
    //保存汇总数
    cdsHeader.Edit;
    cdsHeader.FieldbyName('STOCK_MNY').asFloat := mny;
    cdsHeader.FieldbyName('STOCK_AMT').asFloat := amt;
    cdsHeader.Post;
    try
      //提交保存
      Factor.BeginBatch;
      Factor.AddBatch(cdsHeader,'TStockOrder');
      Factor.AddBatch(cdsDetail,'TStockData');
      Factor.CommitBatch;
      result:=true;
    except
      Factor.CancelBatch;
      cdsHeader.CancelUpdates;
      cdsDetail.CancelUpdates;
      Raise;
    end;
  finally
    cdsHeader.Free;
    cdsDetail.Free;
    Rs.Free;
    Params.Free;
  end;    
end;

procedure TfrmDownStockOrder.AmountToCalc(edtTable: TDataSet; Amount: Real);
var
  rs:TZQuery;
  AMoney,APrice,Agio_Rate,Agio_Money,SourceScale:Real;
  Field:TField;
begin
  if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then
    Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');  
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
end;

class function TfrmDownStockOrder.XsmShow: boolean;
var
  FrmObj: TfrmDownStockOrder;
begin
  Result:=False;
  FrmObj:=TfrmDownStockOrder.Create(nil);
  try
    FrmObj.Xsm := true;
    FrmObj.Show;
    FrmObj.OpenIndeOrderList(1);  //查询订单的主表数据
    result:=true;
  except
    FrmObj.free;
  end;
end;

procedure TfrmDownStockOrder.SetXsm(const Value: boolean);
begin
  FXsm := Value;
end;

procedure TfrmDownStockOrder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if xsm then Action := caFree;
end;

procedure TfrmDownStockOrder.DoXsmAutoStockOrder;
var
  ReRun: Boolean;
  CurObj: TRecord_;
begin
  if MessageBox(self.Handle,pchar('真的要进行到货确认吗？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
  begin
    try
      if CheckIsOrderDown=False then //检查还没入库继续入库
      begin
        DoCopyIndeOrderData;   //复制订单明细数据
        try
          CurObj:=TRecord_.Create;
          CurObj.ReadFromDataSet(cdsTable);  //读取返回值
          ReRun:=IndeOrderWriteToStock(CurObj, FReData); //保存入库
          if ReRun then //到货确认成功
          begin
            cdsTable.Delete;
            if cdsTable.State in [dsEdit,dsInsert] then
              cdsTable.Post;
          end;
        finally
          CurObj.Free;
        end;
      end;
    except
      FAobj.Free;
      MessageBox(Handle,pchar('自动接收订单失败，请手工执行！'),'友情提示...',MB_OK+MB_ICONWARNING);
    end;
  end;
end;

procedure TfrmDownStockOrder.SetINDEOrderMsg;
begin
  LblMsg.Visible:=False;
  LblCount.Visible:=False;
  if cdsTable.Active then
  begin
    LblCount.Caption:=Inttostr(cdsTable.RecordCount);
    LblMsg.Visible:=true;
    LblCount.Visible:=true;
  end;
end;

end.
