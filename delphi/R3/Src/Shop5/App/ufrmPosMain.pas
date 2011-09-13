
{ 13100001	0	收银机	1	查询	2	新增	3	修改	4	删除	5	变价	6	增送	7	兑换	8	审核   }

unit ufrmPosMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzStatus, RzPanel, Grids,
  DBGridEh, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  ZDataSet, ZBase, Math, RzGrids, FR_Class,DBGrids, RzButton,
  ZAbstractRODataset, ZAbstractDataset;

const
  WM_DIALOG_PULL=WM_USER+1;
  //状态改变
  WM_STATUS_CHANGE=WM_USER+2;
  //单据操作
  WM_EXEC_ORDER=WM_USER+3;

  //尺码，颜色编辑框
  PROPERTY_DIALOG=1;
  //批号、有效期输入框
  BATCH_NO_DIALOG=2;
  //添加商品对话框
  ADD_GOODS_DIALOG=3;
  //查询商品对话框
  FIND_GOODS_DIALOG=4;
  //查询会员对话框
  FIND_CUSTOMER_DIALOG=5;
  //查询导购员对话框
  FIND_GUIDE_DIALOG=6;
type
  TfrmPosMain = class(TfrmBasic)
    RzPanel3: TRzPanel;
    RzPanel2: TRzPanel;
    rzinfo1: TRzGroupBox;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    Label2: TLabel;
    fndCLIENT_CODE: TcxTextEdit;
    Label6: TLabel;
    fndCLIENT_ID_TEXT: TcxTextEdit;
    Label1: TLabel;
    fndGLIDE_NO: TcxTextEdit;
    fndSALES_DATE: TcxTextEdit;
    Label5: TLabel;
    RzPanel7: TRzPanel;
    RzStatusPane1: TRzStatusPane;
    RzPanel8: TRzPanel;
    lblHint: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    actNew: TAction;
    actSave: TAction;
    actDelete: TAction;
    actPrint: TAction;
    actAudit: TAction;
    actPrior: TAction;
    actNext: TAction;
    actCancel: TAction;
    actFind: TAction;
    actInfo: TAction;
    actPreview: TAction;
    actEdit: TAction;
    RzStatusPane2: TRzStatusPane;
    RzGroupBox1: TRzGroupBox;
    lblPAY_1: TLabel;
    Label12: TLabel;
    lblDIBS: TLabel;
    lblCASH: TLabel;
    rckPAY_1: TcxTextEdit;
    priPAY_DIBS: TcxTextEdit;
    pnlBarCode: TRzPanel;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    Label17: TLabel;
    edtAMONEY: TcxTextEdit;
    Label7: TLabel;
    edtAGIO_MONEY: TcxTextEdit;
    fndCREA_USER: TcxTextEdit;
    Label4: TLabel;
    fndACCU_INTEGRAL: TcxTextEdit;
    Label30: TLabel;
    edtINTEGRAL: TcxTextEdit;
    Label31: TLabel;
    fndGUIDE_USER: TcxTextEdit;
    Label32: TLabel;
    Label19: TLabel;
    fndBALANCE: TcxTextEdit;
    lblPAY_2: TLabel;
    rckPAY_2: TcxTextEdit;
    lblPAY_3: TLabel;
    rckPAY_3: TcxTextEdit;
    lblPAY_4: TLabel;
    rckPAY_4: TcxTextEdit;
    rzHelp: TRzPanel;
    h2: TLabel;
    h6: TLabel;
    h5: TLabel;
    h11: TLabel;
    h12: TLabel;
    h9: TLabel;
    h10: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    rzHint: TLabel;
    Label11: TLabel;
    Label18: TLabel;
    fndPRICE_ID: TcxTextEdit;
    cdsHeader: TZQuery;
    cdsTable: TZQuery;
    RzStatusPane3: TRzStatusPane;
    Panel1: TPanel;
    dsGodsInfo: TDataSource;
    RzStatusPane5: TRzStatusPane;
    RzStatusPane7: TRzStatusPane;
    DBGridEh2: TDBGridEh;
    RzClockStatus1: TRzClockStatus;
    cdsLocusNo: TZQuery;
    Label3: TLabel;
    lblInputHimt: TLabel;
    Label13: TLabel;
    fndCREA_DATE: TcxTextEdit;
    lblACCT_MNY: TLabel;
    Label15: TLabel;
    edtREMARK: TcxTextEdit;
    cdsICGlide: TZQuery;
    frfSalesOrder: TfrReport;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actAuditExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure cdsTableAfterPost(DataSet: TDataSet);
    procedure fndBARCODEEnter(Sender: TObject);
    procedure fndCLIENT_CODEEnter(Sender: TObject);
    procedure rckPAY_1Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RzStatusPane3Click(Sender: TObject);
    procedure edtInputPropertiesChange(Sender: TObject);
    procedure BasInfoFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure RzStatusPane5Click(Sender: TObject);
    procedure RzStatusPane7Click(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure Label27Click(Sender: TObject);
    procedure h6Click(Sender: TObject);
    procedure Label21Click(Sender: TObject);
    procedure h9Click(Sender: TObject);
    procedure h10Click(Sender: TObject);
    procedure Label22Click(Sender: TObject);
    procedure h2Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label26Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label28Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure h5Click(Sender: TObject);
    procedure h12Click(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure h11Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure edtInputEnter(Sender: TObject);
    procedure frfSalesOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure frfSalesOrderGetValue(const ParName: String;
      var ParValue: Variant);
  private
    FInputFlag: integer;
    Locked:boolean;
    FdbState: TDataSetState;
    FgRepeat: boolean;
    Foid: string;
    Fgid: string;
    KeyStr:string;
    FInputMode: integer;
    Fxsm: boolean;
    FIsReck: boolean;
    FbasInfo: TZQuery;
    //判断当前记录是否有颜色尺管制
    function  PropertyEnabled:boolean;
    procedure SetInputFlag(const Value: integer);
    procedure SetdbState(const Value: TDataSetState);
    { Private declarations }
    procedure WMDialogPull(var Message: TMessage); message WM_DIALOG_PULL;
    procedure WMExecOrder(var Message: TMessage); message WM_EXEC_ORDER;
    procedure OpenDialogGoods;
    procedure OpenDialogProperty;
    function  OpenDialogCustomer(KeyString:string;C_T:Integer=0):boolean;
    procedure OpenDialogGuide;
    procedure OpenDialogTrend;
    procedure AddFromDialog(AObj:TRecord_);
    procedure SetgRepeat(const Value: boolean);
    procedure Setoid(const Value: string);
    procedure Createparams(Var Params:TCreateParams);override;
    procedure Setgid(const Value: string);
    procedure SetInputMode(const Value: integer);
    procedure GodsInfoFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure BarcodeFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure Setxsm(const Value: boolean);
    procedure SetIsReck(const Value: boolean);
    procedure SetbasInfo(const Value: TZQuery);
    function GetbasInfo: TZQuery;
  protected
    //进位法则
    CarryRule:integer;
    //保留小数位
    Deci:integer;
    //结算金额
    TotalFee:Currency;
    TotalAmt:Currency;
    //换购积分
    TotalBarter:integer;
    //默认发票类型
    DefInvFlag:integer;
    //普通税率
    RtlRate2:Currency;
    //增值税率
    RtlRate3:Currency;

    // 散装条码参数
    BulkiFlag:string;
    BulkId:integer;
    Bulk1Flag:integer;
    Bulk2Flag:integer;
    Bulk1Len:integer;
    Bulk2Len:integer;
    Bulk1Dec:integer;
    Bulk2Dec:integer;

    //最低折扣率
    agioLower:Currency;
    //赠品处理,
    RtlPSTFlag:integer;
    RtlGDPC_ID:string;
    Dibs,Cash:Currency;
    GUID,GUNM,STGID,STGNM,STGGNM:string;
    AObj:TRecord_;
    SaveAObj:TRecord_;
    RowID:integer;
    Saved:boolean;
    STGAMT,STGAMOUNT:Currency;
    //多条件定位
    FndStr:string;
    //打印设置
    Printed:boolean;
    //重读所有商品价格
    procedure CalcPrice;
    //输入会员号
    procedure WriteInfo(id:string);
    //整单调价
    procedure AgioInfo(id:string);
    //单笔折扣
    procedure AgioToGods(id:string;vss:boolean=false);
    //修改单价
    procedure PriceToGods(id:string);
    //赠送
    procedure PresentToGods;
    //退货
    procedure ReturnGods;
    //调价
    procedure OpenDialogPrice;

    procedure CheckInvaid;

    //输入跟踪号
    function GodsToLocusNo(id:string):boolean;
    //输入批号
    function GodsToBatchNo(id:string):boolean;

    procedure ShowHeader(flag:integer=0);
    procedure Calc;
    procedure HangUp;
    procedure PickUp;
    procedure Check;
    procedure LookOrder;
    procedure PopupMenu;

    function EnCodeBarcode:string;
    procedure DoPrintTicket(cid,id:string;iFlag:integer=0;cash:Currency=0;dibs:Currency=0);
    procedure DoPrintOrder(id:string);
    //0 找到了 1重复 2没找到
    function DecodeBarcode(BarCode: string):integer;
    procedure AddRecord(AObj: TRecord_; UNIT_ID,P1,P2: string;IsPresent:boolean=false);
    procedure DelRecord(AObj:TRecord_);

    procedure WriteAmount(Amt:Currency;Appended:boolean=false);
    procedure BulkAmount(Amt,Pri,mny:Currency;Appended:boolean=false);

    procedure NewOrder;
    procedure EditOrder;
    procedure DeleteOrder;
    procedure SaveOrder;
    procedure AuditOrder;
    procedure CancelOrder;
    procedure Open(id:string);
    //发放会员卡
    procedure NewCardExecute;
    //会员卡密码修改
    procedure PasswordExecute;
    //会员卡充值
    procedure DepositExecute;
    //会员卡注销
    procedure CancelCardExecute;
    //会员卡退款
    procedure ReturnExecute;
    //会员卡挂失
    procedure LossCardExecute;

    function GetCostPrice(SHOP_ID,GODS_ID,BATCH_NO:string):Currency;

    procedure AmountToCalc(Amount:Currency);
    procedure PriceToCalc(APrice:Currency);
    procedure AMoneyToCalc(AMoney:Currency);
    procedure AgioToCalc(Agio:Currency);
    procedure PresentToCalc(Present:integer);
    procedure UnitToCalc(UNIT_ID:string);
    procedure InitPrice(GODS_ID,UNIT_ID:string;CalcAll:boolean=false);
    procedure ConvertUnit;
    procedure ConvertPresent;
    function PrintSQL(tenantid,id:string):string;

    procedure LoadFile(cName: string);
    function  CheckNotChangePrice(GodsID: string): Boolean; //2011.06.08返回是否企业定价
    function  CheckSale_Limit: Boolean; //2011.06.12判断是否限量


    //断电保护功能
    procedure SaveToFile;
    procedure LoadFromFile;
  public
    { Public declarations }
    // 最近输的货品
    vgds,vP1,vP2,vBtNo:string;
    function FindColumn(FieldName:string):TColumnEh;
    property InputFlag:integer read FInputFlag write SetInputFlag;
    property InputMode:integer read FInputMode write SetInputMode;
    property dbState:TDataSetState read FdbState write SetdbState;
    property gRepeat:boolean read FgRepeat write SetgRepeat;
    property oid:string read Foid write Setoid;
    property gid:string read Fgid write Setgid;
    property xsm:boolean read Fxsm write Setxsm;
    property IsReck:boolean read FIsReck write SetIsReck;
    property basInfo:TZQuery read GetbasInfo write SetbasInfo;
  end;

implementation
uses ufrmMain, ZLogFile, uXDictFactory, uframeSelectCustomer, uShopUtil, uFnUtil, uDsUtil, uExpression, uGlobal, uShopGlobal,
     uframeSelectGoods, uframeDialogProperty, ufrmLogin, ufrmShowDibs, uDevFactory, ufrmCustomerInfo,
     ufrmHangUpFile, uframeListDialog, ufrmPosPrice, IniFiles, ufrmPosMenu, ufrmCloseForDay, ufrmDeposit, ufrmNewCard,
     ufrmCancelCard, ufrmReturn, ufrmPassWord, ufrmLossCard, ufrmPosMainList, ufrmFastReport;
{$R *.dfm}

procedure TfrmPosMain.FormCreate(Sender: TObject);
var
  rs:TZQuery;
  F:TIniFile;
  s:string;
begin
  inherited;
  basInfo := Global.GetZQueryFromName('PUB_GOODSINFO');
  dsGodsInfo.DataSet := basInfo;
  DBGridEh1.Columns[4].Visible := (CLVersion='FIG');
  DBGridEh1.Columns[5].Visible := (CLVersion='FIG');
  SaveAObj := TRecord_.Create;
  Width := 800;
  Height := 600;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    s := '〖'+Global.SHOP_NAME+'〗欢迎使用"'+ F.ReadString('soft','name','云盟软件R3')+'"';
//    if F.ReadString('home','url','')<>'' then
//       s := s+'  网址：'+F.ReadString('home','url','');
//    if F.ReadString('soft','copyright','')<>'' then
//       s := s+'  版权：'+F.ReadString('soft','copyright','');
//    if F.ReadString('soft','telephone','')<>'' then
//       s := s+'  客服：'+F.ReadString('soft','telephone','');
    RzStatusPane2.Caption := s;
  finally
    try
      F.Free;
    except
    end;
  end;
  DBGridEh2.Align := alClient;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'temp\sft.'+Global.UserID);
  try
    rzHelp.Visible := F.ReadBool('收款机界面','Help',true);
    if rzHelp.Visible then
       rzHelp.Top := RzPanel3.Top + RzPanel3.Height-rzHelp.Height+10;
  finally
    try
      F.Free;
    except
    end;
  end;

  if (Screen.DesktopRect.Bottom-Screen.DesktopRect.Top)/(Screen.DesktopRect.Right-Screen.DesktopRect.Left)<600/800 then
     ScaleBy((Screen.DesktopRect.Bottom-Screen.DesktopRect.Top),600)
  else
     ScaleBy((Screen.DesktopRect.Right-Screen.DesktopRect.Left),800);
  SetBounds(Screen.WorkArealeft,Screen.WorkAreaTop,Screen.WorkAreaWidth,Screen.WorkAreaHeight);
  rzinfo1.Width := RzPanel2.ClientWidth div 2 -10;
  
  RtlRate2 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE2'),0.05);
  RtlRate3 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_INV_FLAG'),1);
  // 0是现场领取 1是后台领取
  RtlPSTFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_PST_FLAG'),0);

  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);

  InputMode := StrtoIntDef(ShopGlobal.GetParameter('INPUT_MODE'),0);
  InputFlag := 0;

  RzStatusPane4.Caption := '收银员：'+Global.UserName;

  // 散装条码定义
  BulkiFlag := ShopGlobal.GetParameter('BUIK_FLAG');
  BulkId := StrtoIntDef(ShopGlobal.GetParameter('BUIK_ID'),5)+1;
  Bulk1Flag := StrtoIntDef(ShopGlobal.GetParameter('BUIK_ID1'),0);
  Bulk2Flag := StrtoIntDef(ShopGlobal.GetParameter('BUIK_ID2'),0);
  if Bulk1Flag=0 then
     Bulk1Len :=0
  else
     Bulk1Len := StrtoIntDef(ShopGlobal.GetParameter('BUIK_LEN1'),4)+1;
  if Bulk2Flag=0 then
     Bulk2Len :=0
  else
     Bulk2Len := StrtoIntDef(ShopGlobal.GetParameter('BUIK_LEN2'),4)+1;
  Bulk1Dec := StrtoIntDef(ShopGlobal.GetParameter('BUIK_DEC1'),2);
  Bulk2Dec := StrtoIntDef(ShopGlobal.GetParameter('BUIK_DEC2'),2);
  
  AObj := TRecord_.Create;
  gRepeat := false;

  InitGridPickList(DBGridEh1);
  rs := Global.GeTZQueryFromName('PUB_SIZE_INFO');
  DBGridEh1.Columns[4].KeyList.Add('#');
  DBGridEh1.Columns[4].PickList.Add('无');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[4].KeyList.Add(rs.Fields[0].asString);
      DBGridEh1.Columns[4].PickList.Add(rs.Fields[1].asString);
      rs.Next;
    end;
  rs := Global.GeTZQueryFromName('PUB_COLOR_INFO');
  DBGridEh1.Columns[5].KeyList.Add('#');
  DBGridEh1.Columns[5].PickList.Add('无');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[5].KeyList.Add(rs.Fields[0].asString);
      DBGridEh1.Columns[5].PickList.Add(rs.Fields[1].asString);
      rs.Next;
    end;
  rs := Global.GeTZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[7].KeyList.Add(rs.Fields[0].asString);
      DBGridEh1.Columns[7].PickList.Add(rs.Fields[1].asString);
      rs.Next;
    end;
  rs := Global.GeTZQueryFromName('PUB_TREND_INFO');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[14].KeyList.Add(rs.Fields[0].asString);
      DBGridEh1.Columns[14].PickList.Add(rs.Fields[1].asString);
      rs.Next;
    end;
  inherited;

  NewOrder;
  LoadFile('H');

  DBGridEh2.Options := DBGridEh2.Options + [dgRowSelect];

  lblInputHimt.Visible := ShopGlobal.GetChkRight('14500001',1); 
end;

procedure TfrmPosMain.AddRecord(AObj: TRecord_; UNIT_ID,P1,P2: string;IsPresent:boolean=false);
var
  Pt:integer;
  rs:TZQuery;
  bs:TZQuery;
begin
  if IsPresent then pt := 1 else pt := 0;
  cdsTable.DisableControls;
  try
     begin
//零售，采用流水式记录,不查重复性
//        if not gRepeat then
//            begin
//              if cdsTable.Locate('GODS_ID;BATCH_NO;UNIT_ID;IS_PRESENT;PROPERTY_01;PROPERTY_02',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,'#',UNIT_ID,pt,P1,P2]),[]) then
//                 begin
//                   if cdsTable.FieldbyName('UNIT_ID').AsString<>UNIT_ID then UnitToCalc(UNIT_ID);
//                   if cdsTable.FieldbyName('APRICE').AsFloat <> 0 then Exit;
//                 end;
//            end;
        inc(RowID);
        cdsTable.Append;
        if cdsTable.FindField('SEQNO')<> nil then cdsTable.FindField('SEQNO').asInteger := RowID;
        cdsTable.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
        cdsTable.FieldbyName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
        cdsTable.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
        cdsTable.FieldbyName('BARCODE').AsString := EnCodeBarcode;
        cdsTable.FieldByName('IS_PRESENT').asInteger := pt;
        cdsTable.FieldByName('PROPERTY_01').AsString := P1;
        cdsTable.FieldByName('PROPERTY_02').AsString := P2;
        if UNIT_ID='' then
           cdsTable.FieldbyName('UNIT_ID').AsString := AObj.FieldbyName('CALC_UNITS').AsString
        else
           cdsTable.FieldbyName('UNIT_ID').AsString := UNIT_ID;
        cdsTable.FieldbyName('BATCH_NO').AsString := '#';
        cdsTable.Post;
     end;
  finally
     cdsTable.EnableControls;
  end;
  InitPrice(AObj.FieldbyName('GODS_ID').AsString,UNIT_ID);
  if cdsTable.Recordcount=1 then ShowHeader;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create(AObj.FieldbyName('GODS_NAME').AsString+'在经营商品中没找到，请退出系统重试.');
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select sum(AMOUNT) from STO_STORAGE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+Global.SHOP_ID+''' and GODS_ID='''+AObj.FieldbyName('GODS_ID').AsString+'''';
    Factor.Open(rs);
    STGID := AObj.FieldbyName('GODS_ID').AsString;
    STGAMT := cdsTable.FieldbyName('CALC_AMOUNT').asFloat;
    STGAMOUNT := rs.Fields[0].AsFloat;
    STGNM := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_MEAUNITS'),'UNIT_ID','UNIT_NAME',bs.FieldbyName('CALC_UNITS').AsString);
    STGGNM := AObj.FieldbyName('GODS_NAME').AsString;
    lblInputHimt.Caption := '库存:'+formatFloat('#0.###',STGAMOUNT)+''+STGNM+' 销售:'+floattostr(STGAMT)+''+STGNM+'  品名:'+STGGNM;
  finally
    rs.Free;
  end;
end;
procedure TfrmPosMain.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clWhite;
    DBGridEh1.Canvas.Font.Style :=[fsBold];
    DBGridEh1.Canvas.Font.Color :=clBlack;
//    DBGridEh1.Canvas.Font.Name := '黑体';
//    DBGridEh1.Canvas.Font.Size := Round(DBGridEh1.Canvas.Font.Size * 1.7);
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'GODS_NAME' then
    begin
      if cdsTable.FieldbyName('IS_PRESENT').AsString = '1' then
         s := '(赠送)'+cdsTable.FieldbyName('GODS_NAME').AsString
      else
      if cdsTable.FieldbyName('IS_PRESENT').AsString = '2' then
         s := '(兑换)'+cdsTable.FieldbyName('GODS_NAME').AsString
      else
         s := cdsTable.FieldbyName('GODS_NAME').AsString;
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE);
    end;
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER);
    end;
  if ((gdSelected in State) or (gdFocused in State)) then
    begin
      ARect := Rect;
      DBGridEh1.Canvas.Pen.Color := clRed;
      DBGridEh1.Canvas.Pen.Width := 1;
      DBGridEh1.Canvas.Brush.Style := bsClear;
      DbGridEh1.canvas.Rectangle(ARect);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmPosMain.DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;
       if FindColumn('GODS_CODE')<>nil then
       begin
         if FindColumn('UNIT_ID')=nil then
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width
         else
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width+ FindColumn('UNIT_ID').Width;
       end
       else
       begin
         if FindColumn('UNIT_ID')=nil then
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width
         else
            R.Right := Rect.Right + FindColumn('GODS_CODE').Width+ FindColumn('UNIT_ID').Width;
       end;
       DBGridEh1.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s笔',[Inttostr(cdsTable.RecordCount)]);
       DBGridEh1.Canvas.Font.Style := [fsBold];
       DBGridEh1.Canvas.TextRect(R,(Rect.Right-Rect.Left-DBGridEh1.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;

end;

function TfrmPosMain.FindColumn(FieldName: string): TColumnEh;
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

procedure TfrmPosMain.SetInputFlag(const Value: integer);
begin
  case Value of
  0:begin
      case InputMode of
      0:begin
         lblInput.Caption := '条码输入';
         rzHint.Caption := '切换"货号"输入按[Tab]健';
        end;
      1:begin
         lblInput.Caption := '货号输入';
         rzHint.Caption := '切换"条码"输入按[Tab]健';
        end;
      end;
    end;
  1:begin
      lblInput.Caption := '会员卡号';
      lblHint.Caption := '请输入完整的(会员卡号)后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
  2:begin
      lblInput.Caption := '整单折扣';
      lblHint.Caption := '请输入整单折扣率(如:8折、85折)后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
  3:begin
      lblInput.Caption := '修改单价';
      lblHint.Caption := '请直接输入单价后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
  4:begin
      lblInput.Caption := '单笔折扣';
      lblHint.Caption := '请直接输入当前商品的折扣率(如:8折、85折)后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
  5:begin
      lblInput.Caption := '单位切换';
      lblHint.Caption := '请按Shift健进行单位切换 完毕后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
  6:begin
      lblInput.Caption := '是否赠品';
      lblHint.Caption := '请按Shift健进行赠品切换 完毕后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
  7:begin
      lblInput.Caption := '导购员';
      lblHint.Caption := '请按输入"导购员帐号"后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
//  8:begin
//      lblInput.Caption := '颜色尺码';
//      lblHint.Caption := '请按F6健打开颜色尺码输入框';
//      rzHint.Caption := lblHint.Caption;
//    end;
  9:begin
      lblInput.Caption := '输入数量';
      lblHint.Caption := '请直接输入当前商品的数量后按“回车”';
      rzHint.Caption := lblHint.Caption;
    end;
  10:begin
      lblInput.Caption := '物流条码';
      lblHint.Caption := '请输入物流跟踪号后按“回车”';
    end;
  11:begin
      lblInput.Caption := '商品批号';
      lblHint.Caption := '请输入商品批号后按“回车”';
    end;
  12:begin
      lblInput.Caption := '输入备注';
      lblHint.Caption := '请输入备注后按“回车”';
    end;
  end;
  FInputFlag := Value;
  DBGridEh2.Visible := false;
end;

procedure TfrmPosMain.AgioToCalc(Agio: Currency);
var Agio_Rate:Currency;
    Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (cdsTable.State in [dsEdit,dsInsert]) then cdsTable.Edit;
      if cdsTable.FindField('ORG_PRICE')<>nil then
        begin
          Field := cdsTable.FindField('APRICE');
          if Field<>nil then
             begin
               if Agio=0 then
                  Agio_Rate := 1
               else
                  Agio_Rate := Agio / 100;
               Field.AsString := FormatFloat('#0.000',cdsTable.FindField('ORG_PRICE').AsFloat * Agio_Rate);
               Locked := false;
               PriceToCalc(Field.asFloat);
             end;
        end;
  finally
      Locked := false
  end;
end;

procedure TfrmPosMain.AMoneyToCalc(AMoney: Currency);
var AMount,APrice,Agio_Rate,Agio_Money:Currency;
    Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (cdsTable.State in [dsEdit,dsInsert]) then cdsTable.Edit;
      Field := cdsTable.FindField('AMONEY');
      if Field=nil then Exit;
      Field.AsString := FormatFloat('#0.00',AMoney);
      AMoney := Field.AsFloat;

      Field := cdsTable.FindField('AMOUNT');
      if Field=nil then Exit;
      //取数量
      AMount := Field.asFloat;
      //单价
      if AMount =0 then
         APrice := 0
      else
         APrice := AMoney / AMount;
      Field := cdsTable.FindField('APRICE');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.000',APrice);

      if cdsTable.FindField('ORG_PRICE')=nil then
        begin
          //计算折扣
          Field := cdsTable.FindField('AGIO_RATE');
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
          if cdsTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := cdsTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

          //计算折扣
          Field := cdsTable.FindField('AGIO_RATE');
          if (Field<>nil) and (AMount<>0) then
             begin
                if cdsTable.FindField('ORG_PRICE').AsFloat<>0 then
                   Field.AsString := formatFloat('#0.0',AMoney *100 /(cdsTable.FindField('ORG_PRICE').AsFloat*Amount))
                else
                   Field.AsString := '100';
             end;
        end;
      Field := cdsTable.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',Agio_Money);

      Field := cdsTable.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney) ;
      cdsTable.Post;
      cdsTable.Edit;
  finally
      Locked := false
  end;
end;

procedure TfrmPosMain.AmountToCalc(Amount: Currency);
var
  rs:TZQuery;
  AMoney,APrice,Agio_Rate,Agio_Money,SourceScale:Currency;
  Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (cdsTable.State in [dsEdit,dsInsert]) then cdsTable.Edit;
      rs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
      if not rs.Locate('GODS_ID',cdsTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+cdsTable.FieldbyName('GODS_NAME').AsString+'”');  
      if not (cdsTable.State in [dsEdit,dsInsert]) then cdsTable.Edit;
      if cdsTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('CALC_UNITS').AsString then
         begin
          SourceScale := 1;
         end
      else
      if cdsTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('BIG_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
         end
      else
      if cdsTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('SMALL_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
         end
      else
         begin
          SourceScale := 1;
         end;
      Field := cdsTable.FindField('CALC_AMOUNT');
      if Field<>nil then
         begin
            Field.AsFloat := AMount * SourceScale;
         end;
      Field := cdsTable.FindField('APRICE');
      if Field=nil then Exit;
      Field.AsString := FormatFloat('#0.000',Field.AsFloat);
      //取单价
      APrice := Field.asFloat;
      //算金额
      AMoney := StrtoFloat(FormatFloat('#0.00',APrice * AMount));
      Field := cdsTable.FindField('AMONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney);
      if cdsTable.FindField('ORG_PRICE') = nil then
        begin
          //计算折扣
          Field := cdsTable.FindField('AGIO_RATE');
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
          if cdsTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := cdsTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

          //计算折扣
          Field := cdsTable.FindField('AGIO_RATE');
          if (Field<>nil) and (AMount<>0) then
             begin
                if cdsTable.FindField('ORG_PRICE').AsFloat<>0 then
                   Field.AsString := formatFloat('#0.0',AMoney *100 /(cdsTable.FindField('ORG_PRICE').AsFloat*Amount))
                else
                   Field.AsString := '100';
             end;
        end;
      Field := cdsTable.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',Agio_Money);

      Field := cdsTable.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney) ;
      cdsTable.Post;
      cdsTable.Edit;
  finally
      Locked := false
  end;
end;

procedure TfrmPosMain.ConvertPresent;
var
  Params:TLoginParam;
  allow :boolean;
  r:integer;
begin
  if dbState = dsBrowse then Exit;
  r := cdsTable.FieldbyName('IS_PRESENT').AsInteger;
  if cdsTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');
  if not ShopGlobal.GetChkRight('13100001',6) and not ShopGlobal.GetChkRight('13100001',7) then  //赠送权限
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('13100001',6,Params.UserID);
            if not allow then Raise Exception.Create('你输入的用户没有赠送权限...');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
     if cdsTable.FieldbyName('GODS_ID').AsString='' then Exit;
     if cdsTable.FindField('IS_PRESENT')=nil then Exit;
     case r of
     0:PresentToCalc(1);
     1:PresentToCalc(2);
     else
       PresentToCalc(0);
     end;
  end;
end;

procedure TfrmPosMain.ConvertUnit;
var
  rs:TZQuery;
  uid:string;
begin
  if dbState = dsBrowse then Exit;
  if cdsTable.FieldbyName('GODS_ID').AsString='' then Exit;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  if not rs.Locate('GODS_ID',cdsTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+cdsTable.FieldbyName('GODS_NAME').AsString+'”');  
   if (cdsTable.FieldByName('UNIT_ID').AsString = rs.FieldByName('CALC_UNITS').AsString) and (rs.FieldByName('SMALL_UNITS').AsString<>'') then
      begin
        uid := rs.FieldByName('SMALL_UNITS').AsString;
      end
   else
   if (cdsTable.FieldByName('UNIT_ID').AsString = rs.FieldByName('CALC_UNITS').AsString) and (rs.FieldByName('BIG_UNITS').AsString<>'') then
      begin
        uid := rs.FieldByName('BIG_UNITS').AsString;
      end
   else
   if (cdsTable.FieldByName('UNIT_ID').AsString = rs.FieldByName('SMALL_UNITS').AsString) and (rs.FieldByName('BIG_UNITS').AsString<>'') then
      begin
        uid := rs.FieldByName('BIG_UNITS').AsString;
      end
   else
      uid := rs.FieldByName('CALC_UNITS').AsString;
   if uid=cdsTable.FieldByName('UNIT_ID').AsString then Exit;
   UnitToCalc(uid);
end;

procedure TfrmPosMain.InitPrice(GODS_ID, UNIT_ID: string;CalcAll:boolean=false);
var
  rs,bs,ts:TZQuery;
  Params:TftParamList;
  str,OutLevel:string;
begin
  rs := TZQuery.Create(nil);
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('缓冲数据集中没找到当前商品...');  
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('CarryRule').asInteger := CarryRule;
    Params.ParamByName('Deci').asInteger := Deci;
    Params.ParamByName('CLIENT_ID').asString := AObj.FieldbyName('CLIENT_ID').AsString;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := Global.SHOP_ID;
    Params.ParamByName('GODS_ID').asString := GODS_ID;
    if AObj.FieldbyName('PRICE_ID').AsString='' then
    Params.ParamByName('PRICE_ID').asString := '#' else
    Params.ParamByName('PRICE_ID').asString := AObj.FieldbyName('PRICE_ID').AsString;
    Params.ParamByName('UNIT_ID').asString := UNIT_ID;
    Factor.Open(rs,'TGetSalesPrice',Params);
    if not (cdsTable.State in [dsEdit,dsInsert]) then cdsTable.Edit;
    cdsTable.FieldByName('APRICE').AsFloat := rs.FieldbyName('V_APRICE').AsFloat;
    cdsTable.FieldbyName('ORG_PRICE').AsFloat := rs.FieldbyName('V_ORG_PRICE').AsFloat;
    cdsTable.FieldbyName('COST_PRICE').AsFloat := GetCostPrice(Global.SHOP_ID,GODS_ID,cdsTable.FieldbyName('BATCH_NO').AsString);
    cdsTable.FieldByName('POLICY_TYPE').AsInteger := rs.FieldbyName('V_POLICY_TYPE').AsInteger;
    cdsTable.FieldByName('HAS_INTEGRAL').AsInteger := rs.FieldbyName('V_HAS_INTEGRAL').AsInteger;
    //看是否换购商品
    if bs.FieldByName('USING_BARTER').AsInteger=3 then
       begin
         cdsTable.FieldByName('IS_PRESENT').AsInteger := 2;
         cdsTable.FieldByName('BARTER_INTEGRAL').AsInteger := bs.FieldbyName('BARTER_INTEGRAL').AsInteger;
       end
    else
       begin
         cdsTable.FieldByName('IS_PRESENT').AsInteger := 0;
         cdsTable.FieldByName('BARTER_INTEGRAL').AsInteger := 0;
       end;

    ts := Global.GetZQueryFromName('PUB_TREND_INFO');
    ts.First;
    cdsTable.FieldByName('TREND_ID').AsString := ts.FieldbyName('CODE_ID').AsString;
  finally
    Params.Free;
    rs.Free;
  end;
end;

procedure TfrmPosMain.PresentToCalc(Present: integer);
var
  Field:TField;
  bs:TZQuery;
begin
  if cdsTable.FindField('IS_PRESENT')=nil then Exit;
  if Present in [0,1] then
  begin
    Field := cdsTable.FindField('APRICE');
    if Field=nil then Exit;
    cdsTable.Edit;
    cdsTable.FindField('IS_PRESENT').AsInteger := Present;
    if Present=1 then
       begin
         Field.AsFloat := 0;
         PriceToCalc(0);
       end
    else
       begin
         InitPrice(cdsTable.FieldbyName('GODS_ID').AsString,cdsTable.FieldbyName('UNIT_ID').AsString);
         PriceToCalc(cdsTable.FieldbyName('APRICE').AsFloat);
       end;
    if cdsTable.State in [dsInsert,dsEdit] then cdsTable.Post;
    cdsTable.Edit;
  end
  else
  begin
     bs := Global.GetZQueryFromName('PUB_GOODSINFO');
     if not bs.Locate('GODS_ID',cdsTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+cdsTable.FieldbyName('GODS_NAME').AsString+'”');
     //看是否换购商品
     if bs.FieldByName('USING_BARTER').AsInteger in [2,3] then
        begin
          cdsTable.Edit;
          cdsTable.FieldByName('IS_PRESENT').AsInteger := 2;
          cdsTable.FieldByName('BARTER_INTEGRAL').AsInteger := bs.FieldbyName('BARTER_INTEGRAL').AsInteger;
          if bs.FieldByName('USING_BARTER').AsInteger=2 then
             begin
               cdsTable.FieldByName('APRICE').AsFloat := 0;
               PriceToCalc(0);
             end;
        end
     else
        begin
          MessageBox(Handle,'此商品没有启用积分换购，不能进行兑换','友情提示...',MB_OK+MB_ICONINFORMATION);
          PresentToCalc(0);
        end;
  end;
end;

procedure TfrmPosMain.PriceToCalc(APrice: Currency);
var AMount,AMoney,Agio_Rate,Agio_Money:Currency;
    Field:TField;
begin
  if Locked then Exit;
  Locked := true;
  try
      if not (cdsTable.State in [dsEdit,dsInsert]) then cdsTable.Edit;
      Field := cdsTable.FindField('APRICE');
      if Field=nil then Exit;
      Field.AsString := FormatFloat('#0.000',APrice);
      APrice := Field.AsFloat;

      Field := cdsTable.FindField('AMOUNT');
      if Field=nil then Exit;
      //取数量
      AMount := Field.asFloat;
      //金额
      AMoney := StrtoFloat(FormatFloat('#0.00',AMount * APrice));
      Field := cdsTable.FindField('AMONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney);

      if cdsTable.FindField('ORG_PRICE')=nil then
        begin
          //计算折扣
          Field := cdsTable.FindField('AGIO_RATE');
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
          if cdsTable.FindField('ORG_PRICE').AsFloat=0 then
             Agio_Money := 0
          else
             Agio_Money := cdsTable.FindField('ORG_PRICE').AsFloat*Amount-AMoney;

          //计算折扣
          Field := cdsTable.FindField('AGIO_RATE');
          if (Field<>nil) and (AMount<>0) then
             begin
                if cdsTable.FindField('ORG_PRICE').AsFloat<>0 then
                   Field.AsString := formatFloat('#0.0',AMoney *100 /(cdsTable.FindField('ORG_PRICE').AsFloat*Amount))
                else
                   Field.AsString := '100';
             end;
        end;
      Field := cdsTable.FindField('AGIO_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',Agio_Money);

      Field := cdsTable.FindField('CALC_MONEY');
      if Field<>nil then
         Field.AsString := FormatFloat('#0.00',AMoney) ;
      cdsTable.Post;
      cdsTable.Edit;
  finally
      Locked := false;
  end;
end;

procedure TfrmPosMain.UnitToCalc(UNIT_ID: string);
var AMount,SourceScale:Currency;
    Field:TField;
    rs:TZQuery;
    u:integer;
begin
  if Locked then Exit;
  if UNIT_ID=cdsTable.FieldbyName('UNIT_ID').AsString  then Exit;
  Locked := True;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  try
      if not rs.Locate('GODS_ID',cdsTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+cdsTable.FieldbyName('GODS_NAME').AsString+'”');  
      Field := cdsTable.FindField('AMOUNT');
      if Field=nil then Exit;
      AMount := Field.asFloat;
      if not (cdsTable.State in [dsEdit,dsInsert]) then cdsTable.Edit;
      if cdsTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('CALC_UNITS').AsString then
         begin
          SourceScale := 1;
         end
      else
      if cdsTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('BIG_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
         end
      else
      if cdsTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('SMALL_UNITS').AsString then
         begin
          SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
         end
      else
         begin
          SourceScale := 1;
         end;
      cdsTable.FieldByName('UNIT_ID').AsString := UNIT_ID;
      cdsTable.FieldByName('BARCODE').AsString := EnCodeBarcode; 
      Field := cdsTable.FindField('CALC_AMOUNT');
      if Field<>nil then
         begin
            Field.AsFloat := AMount * SourceScale;
         end;
      if cdsTable.FindField('APRICE')<>nil then
         begin
           InitPrice(cdsTable.FieldByName('GODS_ID').asString,UNIT_ID);
           Locked := false;
           AMountToCalc(AMount);
         end;
  finally
     Locked := false;
  end;
end;

procedure TfrmPosMain.FormShow(Sender: TObject);
begin
  inherited;
//  if ShopGlobal.OffLine then
//     RzStatusPane1.Caption := '离线状态'
//  else
//     RzStatusPane1.Caption := '联机状态';
  LoadFile('H');
end;

procedure TfrmPosMain.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  DBGridEh1.ReadOnly := true;
  case dbState of
  dsInsert:RzStatusPane1.Caption := '新单状态';
  dsEdit:RzStatusPane1.Caption := '修改状态';
  else RzStatusPane1.Caption := '浏览状态';
  end;
end;

procedure TfrmPosMain.FormDestroy(Sender: TObject);
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'temp\sft.'+Global.UserID);
  try
    F.WriteBool('收款机界面','Help',rzHelp.Visible);
  finally
    try
      F.Free;
    except
    end;
  end;
  SaveAObj.Free;
  AObj.free;
  inherited;

end;

procedure TfrmPosMain.WMDialogPull(var Message: TMessage);
begin
  case Message.WParam of
  PROPERTY_DIALOG:OpenDialogProperty;
  BATCH_NO_DIALOG:;
  ADD_GOODS_DIALOG:;
  FIND_GOODS_DIALOG:
    begin
      if Message.lParam = 0 then fndStr := '';
      OpenDialogGoods;
    end;
  FIND_GUIDE_DIALOG:OpenDialogGuide;
  FIND_CUSTOMER_DIALOG:OpenDialogCustomer(KeyStr);
  end;
end;

procedure TfrmPosMain.AddFromDialog(AObj: TRecord_);
begin
  basInfo.Filtered := false;
  if not basInfo.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到"'+AObj.FieldbyName('GODS_NAME').AsString+'"'); 
  AddRecord(AObj,basInfo.FieldbyName('CALC_UNITS').AsString,'#','#',True);
  if not PropertyEnabled then
     WriteAmount(1,true)
  else
     OpenDialogProperty; 
end;

procedure TfrmPosMain.OpenDialogGoods;
var AObj:TRecord_;
begin
  if dbState = dsBrowse then Exit;
  if IsReck then Raise Exception.Create('你已经做了交班结账了不能再收银，请到结账管理撤销结账后再操作。'); 
  with TframeSelectGoods.Create(self) do
    begin
      try
        edtSearch.Text := fndStr;
        MultiSelect := false;
        OnSave := AddFromDialog;
        if ShowModal=MROK then
           begin
             cdsTable.DisableControls;
             try
             cdsList.first;
             while not cdsList.eof do
               begin
                 AObj := TRecord_.Create;
                 try
                   AObj.ReadFromDataSet(cdsList);
                   AddFromDialog(AObj);
                 finally
                   AObj.Free;
                 end;
                 cdsList.Next;
               end;
             finally
               SaveToFile;
               cdsTable.EnableControls;
             end;
             Calc;
           end;
      finally
        free;
      end;
    end;
end;

procedure TfrmPosMain.SetgRepeat(const Value: boolean);
begin
  FgRepeat := Value;
end;

function TfrmPosMain.PropertyEnabled: boolean;
var
  rs:TZQuery;
begin
  result := false;
  rs := Global.GeTZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',cdsTable.FieldbyName('GODS_ID').AsString,[]) then 
  result := not (
       ((rs.FieldbyName('SORT_ID7').AsString = '') or (rs.FieldbyName('SORT_ID7').AsString = '#'))
         and
       ((rs.FieldbyName('SORT_ID8').AsString = '') or (rs.FieldbyName('SORT_ID8').AsString = '#'))
       );
end;

procedure TfrmPosMain.OpenDialogProperty;
var
  AObj:TRecord_;
  i:integer;
begin
  if dbState = dsBrowse then Exit;
  if cdsTable.FieldbyName('GODS_ID').AsString = '' then Exit;
  if not PropertyEnabled then Exit;
  AObj := TRecord_.Create;
  cdsTable.DisableControls;
  try
    AObj.ReadFromDataSet(cdsTable);
    if TframeDialogProperty.SimpleShowDialog(self,AObj,dbState) then
       begin
         if cdsTable.FieldByName('AMOUNT').AsFloat = 0 then cdsTable.Delete;
         //不需添加记录,对当前记录进行修改属性
         //AddRecord(AObj,
         //  AObj.FieldbyName('UNIT_ID').AsString,
         //  AObj.FieldbyName('PROPERTY_01').AsString,
         //  AObj.FieldbyName('PROPERTY_02').AsString,(AObj.FieldbyName('IS_PRESENT').AsString='1')
         //);
         cdsTable.Edit;
         cdsTable.FieldbyName('PROPERTY_01').AsString := AObj.FieldbyName('PROPERTY_01').AsString;
         cdsTable.FieldbyName('PROPERTY_02').AsString := AObj.FieldbyName('PROPERTY_02').AsString;
         cdsTable.FieldbyName('AMOUNT').AsFloat := cdsTable.FieldbyName('AMOUNT').AsFloat + AObj.FieldbyName('AMOUNT').AsFloat;
         AMountToCalc(cdsTable.FieldbyName('AMOUNT').AsFloat);
         if cdsTable.ControlsDisabled then Calc;
       end;
  finally
    cdsTable.EnableControls;
    AObj.Free;
  end;
end;

procedure TfrmPosMain.edtInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = []) and(Key = VK_TAB) then
     begin
       if InputMode = 0 then InputMode := 1 else InputMode := 0;
       InputFlag := InputFlag;
       Key := 0;
     end;
  if (Shift = []) and(Key = VK_F11) then
     begin
       if (dbState = dsBrowse) then Exit;
       ConvertUnit;
     end;
  if (Shift = []) and(Key = VK_F4) then
     begin
       if (dbState = dsBrowse) then Exit;
       ConvertPresent;
     end;
  if (Shift = []) and(Key = VK_F9) then
     begin
       if (dbState = dsBrowse) then Exit;
       PostMessage(Handle,WM_DIALOG_PULL,FIND_GUIDE_DIALOG,1);
     end;

  if (Shift = []) and(Key = VK_F12) then
     begin
       if (dbState = dsBrowse) then Exit;
       OpenDialogPrice;
     end;


  if (Shift = []) and (Key=VK_DOWN) then
      begin
      if (InputFlag=0) and (InputMode=1) and DBGridEh2.Visible then
        basInfo.Next
      else
        cdsTable.Next;
      end;
      
  if (Shift = []) and (Key=VK_UP) then
      begin
      if (InputFlag=0) and (InputMode=1) and DBGridEh2.Visible then
        basInfo.Prior
      else
        cdsTable.Prior;
      end;

  if (Shift = []) and (Key=VK_ESCAPE) then
     begin
       if InputFlag<>0 then
          begin
            edtInput.Text := '';
            DBGridEh1.Col := 1;
            InputFlag := 0;
          end;
     end;

end;

procedure TfrmPosMain.edtInputKeyPress(Sender: TObject; var Key: Char);
var
  s:string;
  IsNumber,IsFind,isAdd:Boolean;
  amt:Currency;
  AObj:TRecord_;
begin

  inherited;
  if Key=#13 then
    begin
      if (dbState = dsBrowse) then NewOrder;
      if (InputFlag=0) and (InputMode=1) then
         begin
           if DBGridEh2.Visible then
              begin
                if basInfo.isEmpty then Raise Exception.Create('您输入的货号"'+edtInput.Text+'"无效...');
                AObj := TRecord_.Create;
                try
                   AObj.ReadFromDataSet(BasInfo);
                   AddFromDialog(AObj);
                   edtInput.Text := '';
                   if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
                   Key := #0;
                finally
                   AObj.Free;
                end;
                Exit;
              end;
         end;
      s := trim(edtInput.Text);
      try
      edtInput.Text := '';
      if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
      Key := #0;
      KeyStr := s;
      if InputFlag=1 then //会员卡号
         begin
           WriteInfo(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=2 then //整单折扣
         begin
           if s<>'' then AgioInfo(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=3 then //单价
         begin
           if s<>'' then PriceToGods(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=4 then //折扣率
         begin
           if s<>'' then AgioToGods(s);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=9 then //数量
         begin
           if s='' then Exit;
           try
             amt := StrtoFloat(s);
           except
             Raise Exception.Create('请输入正确的数值型数量.');
           end;
           if cdsTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');
           if amt=0 then Raise Exception.Create('不能输入0数量'); 
           WriteAmount(amt,false);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=8 then //颜色尺码
         begin
           PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,0);
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=10 then //物流跟踪号
         begin
           if s<>'' then if not GodsToLocusNo(s) then Exit;
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=11 then //商品批号
         begin
           if s<>'' then if not GodsToBatchNo(s) then Exit;
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=5 then //单位
         begin
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=6 then //赠品
         begin
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      if InputFlag=12 then //备注
         begin
           if s='' then Exit;
           edtREMARK.Text := s;
           InputFlag := 0;
           DBGridEh1.Col := 1;
           Exit;
         end;
      isAdd := false;
      if s='' then
         begin
           fndStr := '';
           PostMessage(Handle,WM_DIALOG_PULL,FIND_GOODS_DIALOG,0);
           Exit;
         end;
      IsNumber := false;
      if s[1]='=' then
         begin
           isAdd := false;
           Delete(s,1,1);
           if FnString.IsNumberChar(s) then
              amt := StrtoFloatDef(s,0)
           else
              begin
                try
                  amt := GetExpressionValue(s,nil);
                except
                  Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.InvaildExpression','"%s"是无效计算公式.',[trim(edtInput.Text)]));
                end;
              end;
           IsNumber := true;
         end ;
      if ((length(s) in [1,2,3,4]) and FnString.IsNumberChar(s)) or IsNumber then
         begin
           if trim(s)='' then Exit;
           if cdsTable.FieldbyName('GODS_ID').asString='' then Exit;
           if not IsNumber then
              begin
                try
                  amt := StrtoFloat(s);
                except
                  Raise Exception.Create(s+'为无效数值型...');
                end;
              end;
           if amt=0 then
              begin
                Raise Exception.Create('不能输入0数量'); 
              end
           else
              begin
                WriteAmount(amt,isAdd)
              end;
         end
      else
         begin
           case DecodeBarCode(trim(s)) of
           1:PostMessage(Handle,WM_DIALOG_PULL,FIND_GOODS_DIALOG,1);
           2:case InputMode of
             0: MessageBox(Handle,pchar('输入的“'+trim(s)+'”是无效条码...'),'友情提示...',MB_OK+MB_ICONINFORMATION);
             1: MessageBox(Handle,pchar('输入的“'+trim(s)+'”是无效货号...'),'友情提示...',MB_OK+MB_ICONINFORMATION);
             end;
           3:begin
               edtInput.Text := '';
               Exit;
             end;
           end;
         end;
      except
         edtInput.Text := s;
         edtInput.SelectAll;
         Raise;
      end;
    end;
  if Key='-' then
    begin
      if dbState = dsBrowse then Exit;
      if MessageBox(Handle,'请确认是否删除当前选中的商品?','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
      AObj := TRecord_.Create;
      try
         AObj.ReadFromDataSet(cdsTable);
         DelRecord(AObj)
      finally
         AObj.Free;
      end;
      Key := #0;
    end;
end;

procedure TfrmPosMain.AgioInfo(id: string);
var
  Field:TField;
  s:string;
  r:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  if not ShopGlobal.GetChkRight('13100001',5) then //调价权限
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('13100001',5,Params.UserID);
            if not allow then Raise Exception.Create('输入的用户没有调价权限');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
    s := trim(id);
    try
      if StrToFloat(s)<10 then s := floattostr(StrToFloat(s)*10);
    except
      Raise Exception.Create('输入的折扣率无效，请正确输入；如:9折录入 9');
    end;
    if StrToFloat(s)>100 then Raise Exception.Create('输入的折扣率过大，请确认是否输入正确');
    Field := cdsTable.FindField('AGIO_RATE');
    if Field=nil then Exit;
    cdsTable.DisableControls;
    try
      cdsTable.First;
      while not cdsTable.Eof do
        begin
          if cdsTable.FieldbyName('GODS_ID').asString<>'' then
             begin
                AgioToGods(id,true);
             end;
          cdsTable.Next;
        end;
    finally
      cdsTable.EnableControls;
    end;
  end;
end;

procedure TfrmPosMain.AgioToGods(id: string;vss:boolean=false);
var
  Field:TField;
  s:string;
  Params:TLoginParam;
  allow :boolean;
  op:real;
  bs:TZQuery;
begin
  if cdsTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');

  //2011.06.08 Add 供应链限制改价：
  if CheckNotChangePrice(cdsTable.fieldbyName('GODS_ID').AsString) then
  begin
    if not vss then Raise Exception.Create('商品〖'+cdsTable.FieldByName('GODS_NAME').AsString+'〗不允许调价销售！');
    Exit;
  end;

  if not vss then
  begin
  if not ShopGlobal.GetChkRight('13100001',5) then //调价权限
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('13100001',5,Params.UserID);
            if not allow then Raise Exception.Create('输入的用户没有调价权限');
          end
       else
          allow := false;
     end else allow := true;
  end
  else
     allow := true;
  if allow then
  begin
    s := trim(id);
    try
      if StrToFloat(s)<10 then s := floattostr(StrToFloat(s)*10);
    except
      Raise Exception.Create('输入的折扣率无效，请正确输入；如:9折录入 9');
    end;
    if StrToFloat(s)>100 then Raise Exception.Create('输入的折扣率过大，请确认是否输入正确');
    Field := cdsTable.FindField('AGIO_RATE');
    if Field=nil then Exit;
    cdsTable.DisableControls;
    try
      cdsTable.Edit;
      op := cdsTable.FieldbyName('APRICE').AsFloat;
      if StrToCurr(s) < agioLower then Raise Exception.Create('最低售价不能低于'+formatFloat('#0.000',agioLower)+'%折');
      Field.AsFloat := StrToCurr(s);
      cdsTable.FieldbyName('POLICY_TYPE').AsInteger := 4;
      AgioToCalc(Field.AsFloat);
      bs := Global.GetZQueryFromName('PUB_GOODSINFO');
      if bs.Locate('GODS_ID',cdsTable.FieldbyName('GODS_ID').AsString,[]) and (cdsTable.FieldByName('CALC_AMOUNT').AsCurrency<>0) then
         begin
           if RoundTo(cdsTable.FieldByName('CALC_MONEY').AsCurrency/cdsTable.FieldByName('CALC_AMOUNT').AsCurrency,-3)<bs.FieldByName('NEW_LOWPRICE').AsCurrency then
           begin
             cdsTable.Edit;
             cdsTable.FieldbyName('APRICE').AsFloat := op;
             PriceToCalc(op);
             Raise Exception.Create('最低售价不能低于'+formatFloat('#0.000',bs.FieldByName('NEW_LOWPRICE').AsFloat)+'元');
           end;
         end;
    finally
      cdsTable.EnableControls;
    end;
  end;
end;

procedure TfrmPosMain.PriceToGods(id: string);
var
  r,op:Currency;
  s:string;
  Field:TField;
  bs:TZQuery;
begin
  if cdsTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');
  s := trim(id);
  try
    StrToFloat(s);
    if abs(StrToFloat(s))>999999999 then Raise Exception.Create('输入的单价值过大，请确认是否输入正确');
  except
    Raise Exception.Create('输入的单价无效，请正确输入');
  end;

  Field := cdsTable.FindField('APRICE');
  if Field=nil then Exit;
  cdsTable.Edit;
  op := Field.AsFloat;
  Field.AsFloat := StrToFloat(s);
  PriceToCalc(Field.AsFloat);
  if cdsTable.FieldbyName('AGIO_RATE').AsFloat < agioLower then
     begin
       cdsTable.Edit;
       Field.AsFloat := op;
       PriceToCalc(Field.AsFloat);
       Raise Exception.Create('最低售价不能低于'+formatFloat('#0.000',agioLower)+'%折');
     end;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if bs.Locate('GODS_ID',cdsTable.FieldbyName('GODS_ID').AsString,[]) and (cdsTable.FieldByName('CALC_AMOUNT').AsCurrency<>0) then
     begin
       if RoundTo(cdsTable.FieldByName('CALC_MONEY').AsCurrency/cdsTable.FieldByName('CALC_AMOUNT').AsCurrency,-3)<bs.FieldByName('NEW_LOWPRICE').AsCurrency then
       begin
         cdsTable.Edit;
         Field.AsFloat := op;
         PriceToCalc(op);
         Raise Exception.Create('最低售价不能低于'+formatFloat('#0.000',bs.FieldByName('NEW_LOWPRICE').AsFloat)+'元');
       end;
     end;
  cdsTable.Edit;
  cdsTable.FieldbyName('POLICY_TYPE').AsInteger := 4;
end;

procedure TfrmPosMain.WriteInfo(id: string);
var
  rs:TZQuery;
  SObj:TRecord_;
begin
  inherited;
  rs := TZQuery.Create(nil);
  SObj := TRecord_.Create;
  try
    if id='' then
    begin
      if not OpenDialogCustomer('') then Exit;
      rs.SQL.Text :=
        'select j.*,c.UNION_NAME from ('+
        'select B.IC_CARDNO,A.CLIENT_NAME,A.CLIENT_SPELL,A.CLIENT_ID,A.CLIENT_CODE,A.INTEGRAL,B.BALANCE,A.PRICE_ID,B.UNION_ID from VIW_CUSTOMER A left outer join PUB_IC_INFO B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
        'where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CLIENT_ID='''+AObj.FieldbyName('CLIENT_ID').AsString+''' and A.COMM not in (''02'',''12'') ) j left outer join '+
        '(select UNION_ID,UNION_NAME from PUB_UNION_INFO '+
        ' union all '+
        ' select ''#'' as UNION_ID,''企业客户'' as UNION_NAME from CA_TENANT where TENANT_ID='+inttostr(Global.TENANT_ID)+'  '+
        ') c on j.UNION_ID=c.UNION_ID ';
      Factor.Open(rs);
    end
    else
    begin
      rs.SQL.Text :=
        'select j.*,c.UNION_NAME from ('+
        'select B.IC_CARDNO,A.CLIENT_NAME,A.CLIENT_SPELL,A.CLIENT_ID,A.CLIENT_CODE,A.INTEGRAL,B.BALANCE,A.PRICE_ID,B.UNION_ID from VIW_CUSTOMER A,PUB_IC_INFO B where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
        'and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and B.IC_CARDNO='''+id+''' and B.IC_STATUS in (''0'',''1'') and B.COMM not in (''02'',''12'') ) j left outer join '+
        '(select UNION_ID,UNION_NAME from PUB_UNION_INFO '+
        ' union all '+
        ' select ''#'' as UNION_ID,''企业客户'' as UNION_NAME from CA_TENANT where TENANT_ID='+inttostr(Global.TENANT_ID)+'  '+
        ') c on j.UNION_ID=c.UNION_ID ';
      Factor.Open(rs);
      if rs.IsEmpty then
         begin
          rs.Close;
          rs.SQL.Text :=
            'select j.*,c.UNION_NAME from ('+
            'select B.IC_CARDNO,A.CLIENT_NAME,A.CLIENT_SPELL,A.CLIENT_ID,A.CLIENT_CODE,A.INTEGRAL,B.BALANCE,A.PRICE_ID,B.UNION_ID from VIW_CUSTOMER A left outer join PUB_IC_INFO B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
            'where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and (A.TELEPHONE2='''+id+''' or A.LICENSE_CODE='''+id+''') and A.COMM not in (''02'',''12'') ) j left outer join '+
            '(select UNION_ID,UNION_NAME from PUB_UNION_INFO '+
            ' union all '+
            ' select ''#'' as UNION_ID,''企业客户'' as UNION_NAME from CA_TENANT where TENANT_ID='+inttostr(Global.TENANT_ID)+'  '+
            ') c on j.UNION_ID=c.UNION_ID ';
          Factor.Open(rs);
         end;
    end;
    if rs.IsEmpty then Raise Exception.Create('没有找到此会员资料.'); 
    if rs.RecordCount = 1 then
       SObj.ReadFromDataSet(rs)
    else
    if rs.RecordCount = 2 then
       begin
         rs.First;
         while not rs.Eof do
           begin
             if rs.FieldByName('UNION_ID').AsString <> '#' then
                begin
                  break;
                end;
             rs.Next;
           end;
         SObj.ReadFromDataSet(rs);
       end
    else
       if not TframeListDialog.FindDialog(self,rs.SQL.Text,'IC_CARDNO=卡号,CLIENT_NAME=客户名称,UNION_NAME=商盟',SObj) then Exit;
    AObj.FieldbyName('UNION_ID').AsString := SObj.FieldbyName('UNION_ID').AsString;
    AObj.FieldbyName('IC_CARDNO').AsString := SObj.FieldbyName('IC_CARDNO').AsString;
    AObj.FieldbyName('CLIENT_ID').AsString := SObj.FieldbyName('CLIENT_ID').AsString;
    AObj.FieldbyName('CLIENT_CODE').AsString := SObj.FieldbyName('CLIENT_CODE').AsString;
    AObj.FieldbyName('CLIENT_ID_TEXT').AsString := SObj.FieldbyName('CLIENT_NAME').AsString;
    AObj.FieldbyName('PRICE_ID').AsString := SObj.FieldbyName('PRICE_ID').AsString;
    AObj.FieldbyName('BALANCE').AsFloat := SObj.FieldbyName('BALANCE').AsFloat;
    AObj.FieldbyName('ACCU_INTEGRAL').AsFloat := SObj.FieldbyName('INTEGRAL').AsFloat;
    CalcPrice;
    ShowHeader;
  finally
    SObj.Free;
    rs.Free;
  end;
end;

procedure TfrmPosMain.BulkAmount(Amt, Pri, mny: Currency; Appended: boolean);
begin
   if PropertyEnabled then Raise Exception.Create(XDictFactory.GetMsgString('frame.NoSupportPropertyEnabled','散装商品不支持带颜色及尺码属性的商品...'));
   if Pri<>0 then
      begin
        if (cdsTable.FindField('APRICE')<>nil) then
           begin
             cdsTable.FieldbyName('APRICE').AsFloat := Pri;
           end;
      end;
   if amt<>0 then
      begin
        if (cdsTable.FindField('AMOUNT')<>nil) then
           begin
             if Appended then
                cdsTable.FieldbyName('AMOUNT').AsFloat := cdsTable.FieldbyName('AMOUNT').AsFloat+amt
             else
                cdsTable.FieldbyName('AMOUNT').AsFloat := amt;
             AMountToCalc(cdsTable.FieldbyName('AMOUNT').AsFloat);
           end;
      end;
   if mny<>0 then
      begin
        if (cdsTable.FindField('AMONEY')<>nil) then
           begin
             if Appended then
                cdsTable.FieldbyName('AMONEY').AsFloat := cdsTable.FieldbyName('AMONEY').AsFloat + mny
             else
                cdsTable.FieldbyName('AMONEY').AsFloat := mny;
             if (amt=0) and (cdsTable.FindField('AMOUNT')<>nil) then
               begin
                 if (cdsTable.FindField('APRICE')<>nil) and (cdsTable.FindField('APRICE').AsFloat<>0) then
                    begin
                      amt := RoundTo(cdsTable.FieldbyName('AMONEY').AsFloat / cdsTable.FieldbyName('APRICE').AsFloat,-2);
                    end
                 else
                    amt := 0;
                 cdsTable.FieldbyName('AMOUNT').AsFloat := amt;
               end;
           end;
      end;
end;

function TfrmPosMain.DecodeBarcode(BarCode: string): integer;
var
  rs:TZQuery;
  AObj:TRecord_;
  r,bulk:Boolean;
  uid:string;
  amt:Currency;
  mny:Currency;
  Pri:Currency;
begin
  if IsReck then Raise Exception.Create('你已经做了交班结账了不能再收银，请到结账管理撤销结账后再操作。'); 
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
//  rs := TZQuery.Create(nil);
  try
    if InputMode=0 then
    begin
      rs := Global.GetZQueryFromName('PUB_BARCODE');
      rs.OnFilterRecord := BarcodeFilterRecord;
      rs.Filtered := true;
//      case Factor.iDbType of
//      0,3:rs.SQL.Text := 'select A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.UNIT_ID,A.BATCH_NO from VIW_BARCODE A where TENANT_ID=:TENANT_ID and A.BARCODE like ''%''+:BARCODE and A.COMM not in (''02'',''12'')';
//      1,4,5:rs.SQL.Text := 'select A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.UNIT_ID,A.BATCH_NO from VIW_BARCODE A where TENANT_ID=:TENANT_ID and A.BARCODE like ''%''||:BARCODE and A.COMM not in (''02'',''12'')';
//      end;
//      rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
//      rs.ParamByName('BARCODE').AsString := Barcode;
//      Factor.Open(rs);
    end
    else
      rs := nil;
      if not assigned(rs) or ((InputMode=0) and rs.IsEmpty) then
         begin
            //看看货号是否存在
            rs := Global.GetZQueryFromName('PUB_GOODSINFO');
            rs.Filtered := false;
            rs.OnFilterRecord := GodsInfoFilterRecord;
            rs.Filtered := true;
            //rs.Close;
            //rs.SQL.Text := 'select GODS_ID,CALC_UNITS as UNIT_ID from VIW_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and GODS_CODE=:GODS_CODE';
            //rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            //rs.ParamByName('GODS_CODE').AsString := Barcode;
            //Factor.Open(rs);
            if rs.IsEmpty then
               begin
                 Exit;
               end;
            if (rs.RecordCount > 1) and not TframeListDialog.FindDSDialog(self,rs,'GODS_CODE=货号,GODS_NAME=商品名称,NEW_OUTPRICE=标准售价',nil) then
               begin
                 fndStr := '';
                 result := 3;
                 Exit;
               end
            else
               begin
                 vgds := rs.FieldbyName('GODS_ID').AsString;
                 vP1 := '#';
                 vP2 := '#';
                 vBtNo := '#';
                 uid := rs.FieldbyName('UNIT_ID').asString;
               end;
         end
      else
         begin
            if (rs.RecordCount > 1) and not rs.Locate('BARCODE',BarCode,[]) then
               begin
                  fndStr := '';
                  rs.first;
                  while not rs.eof do
                    begin
                      if fndStr<>'' then fndStr := fndStr+',';
                      fndStr := fndStr + ''''+rs.FieldbyName('GODS_ID').asString+'''';
                      rs.next;
                    end;
                  AObj := TRecord_.Create;
                  try
                    if not TframeListDialog.FindDialog(self,'select GODS_ID,GODS_CODE,GODS_NAME,NEW_OUTPRICE from VIW_GOODSINFO where TENANT_ID='+inttostr(Global.TENANT_ID)+' and GODS_ID in ('+fndStr+') and COMM not in (''02'',''12'')','GODS_CODE=货号,GODS_NAME=商品名称,NEW_OUTPRICE=标准售价',AObj) then
                       begin
                         fndStr := '';
                         result := 3;
                         Exit;
                       end
                    else
                       rs.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]);
                  finally
                    AObj.free;
                  end;
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
    if Assigned(rs) then
    begin
    rs.OnFilterRecord := nil;
    rs.filtered := false;
    end;
  end;
  end;
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  AObj := TRecord_.Create;
  try
    if rs.Locate('GODS_ID',vgds,[]) then
       AObj.ReadFromDataSet(rs)
    else
       Exit;
    result := 0;
    AddRecord(AObj,uid,vP1,vP2,false);
    cdsTable.Edit;
    cdsTable.FieldbyName('BATCH_NO').AsString := vBtNo;
    if not Bulk then
       WriteAmount(1,true)
    else
       BulkAmount(amt,pri,mny,true);
  finally
    AObj.Free;
  end;
  if result=0 then MessageBeep(0);
end;

procedure TfrmPosMain.DelRecord(AObj: TRecord_);
begin
  if not cdsTable.IsEmpty then cdsTable.Delete;
  SaveToFile;
  Calc;
end;

function TfrmPosMain.OpenDialogCustomer(KeyString:string;C_T:Integer=0):boolean;
begin
  result := false;
  if dbState = dsBrowse then Exit;
  with TframeSelectCustomer.Create(self) do
    begin
      try
        edtSearch.Text := KeyString;
        CustType := C_T;
        Open('');
        if ShowModal=MROK then
           begin
             AObj.FieldbyName('CLIENT_ID').AsString := cdsList.FieldbyName('CLIENT_ID').AsString;
             AObj.FieldbyName('CLIENT_ID_TEXT').AsString := cdsList.FieldbyName('CLIENT_NAME').AsString;
             result := true;
           end;
      finally
        free;
      end;
    end;
end;

procedure TfrmPosMain.WriteAmount(Amt: Currency; Appended: boolean);
var b:boolean;
begin
  b := PropertyEnabled;
  if b and ((cdsTable.FieldbyName('PROPERTY_01').AsString='#') and (cdsTable.FieldbyName('PROPERTY_02').AsString='#') and (cdsTable.FieldbyName('AMOUNT').AsFloat=0)) then
     begin
       PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,0);
       Exit;
     end;
  if abs(amt)>999999999 then Raise Exception.Create('输入的数量值过大，请确认是否正确输入...');
  cdsTable.Edit;
  if Appended then
     cdsTable.FieldbyName('AMOUNT').AsFloat := cdsTable.FieldbyName('AMOUNT').AsFloat + amt
  else
     cdsTable.FieldbyName('AMOUNT').AsFloat := amt;
  AMountToCalc(cdsTable.FieldbyName('AMOUNT').AsFloat);
  cdsTable.Post;
end;

procedure TfrmPosMain.AuditOrder;
begin

end;

procedure TfrmPosMain.CancelOrder;
begin

end;

procedure TfrmPosMain.DeleteOrder;
begin
  if dbState = dsBrowse then
     begin
       NewOrder;
       Exit;
     end;
//  if cdsTable.IsEmpty then Raise Exception.Create('已经是一张空单，不能再执行清屏操作');
  if MessageBox(Handle,'是否删除当前未结帐单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then Exit;
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\pos.dat');
  NewOrder;
end;

procedure TfrmPosMain.EditOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if cdsHeader.FieldbyName('CHK_DATE').AsString<>'' then Raise Exception.Create('已经审核的单据不能修改');
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
end;

procedure TfrmPosMain.NewOrder;
var
  rs:TZQuery;
begin
  inherited;
  Open('');
  STGID := '';
  STGNM := '';
  STGGNM := '';
  STGAMT := 0;
  STGAMOUNT := 0;
  lblInputHimt.Caption := '';
  if not ShopGlobal.GetChkRight('13100001',2) then
     Raise Exception.Create('  您没有新增权限，请联系管理员！  ');
  dbState := dsInsert;
  AObj.FieldbyName('SALES_ID').asString := TSequence.NewId();
  AObj.FieldbyName('GLIDE_NO').asString := '..新增..';
  oid := AObj.FieldbyName('SALES_ID').asString;
  gid := AObj.FieldbyName('GLIDE_NO').asString;
  AObj.FieldbyName('SALES_DATE').asInteger := strtoint(formatDatetime('YYYYMMDD',Global.SysDate));
  AObj.FieldbyName('CREA_DATE').AsString := formatDatetime('YYYYMMDD HH:NN:SS',now());

  rs := ShopGlobal.GetDeptInfo;
  AObj.FieldbyName('DEPT_ID').AsString := rs.FieldbyName('DEPT_ID').AsString;

  AObj.FieldbyName('CREA_USER').AsString := Global.UserID;
  AObj.FieldbyName('CREA_USER_TEXT').AsString := Global.UserName;
  if ShopGlobal.GetParameter('GUIDE_USER')<>'0' then
  begin
     AObj.FieldByName('GUIDE_USER').AsString := Global.UserId;
     AObj.FieldByName('GUIDE_USER_TEXT').AsString := Global.UserName;
  end;
  AObj.FieldbyName('INVOICE_FLAG').AsInteger := DefInvFlag;
  case DefInvFlag of
  1:AObj.FieldbyName('TAX_RATE').AsFloat := 0;
  2:AObj.FieldbyName('TAX_RATE').AsFloat := RtlRate2;
  3:AObj.FieldbyName('TAX_RATE').AsFloat := RtlRate3;
  end;

  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select MAX(CLSE_DATE) from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER';
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    rs.Params.ParamByName('CREA_USER').AsString := Global.UserID;
    Factor.Open(rs);
    if rs.Fields[0].AsString >= formatDatetime('YYYYMMDD',Global.SysDate) then
       IsReck := true
    else
       IsReck := false;
  finally
    rs.Free;
  end;
  InputFlag := 0;
  RowId := 0;
  edtREMARK.Text := '输入备注按[\]键';
  ShowHeader;

  LoadFromFile;
end;

procedure TfrmPosMain.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SALES_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TSalesOrder',Params);
      Factor.AddBatch(cdsTable,'TSalesData',Params);
      Factor.AddBatch(cdsLocusNo,'TSalesForLocusNo',Params);
      Factor.AddBatch(cdsIcGlide,'TSalesICData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(cdsHeader);
    oid := id;
    gid := AObj.FieldbyName('GLIDE_NO').AsString;
    dbState := dsBrowse;
    cdsTable.Last;
    agioLower := 0;
    RowId := cdsTable.FieldbyName('SEQNO').AsInteger;
  finally
    Params.Free;
  end;
  cdsTable.DisableControls;
  try
    cdsLocusNo.First;
    while not cdsLocusNo.Eof do
      begin
        if cdsTable.Locate('SEQNO',cdsLocusNo.FieldbyName('SEQNO').AsInteger,[]) then
           begin
             cdsTable.Edit;
             cdsTable.FieldByName('LOCUS_NO').AsString := cdsLocusNo.FieldByName('LOCUS_NO').AsString;
             cdsTable.Post; 
           end;
        cdsLocusNo.Next;
      end;
  finally
    cdsTable.EnableControls;
  end;
  ShowHeader;
  calc;
end;

procedure TfrmPosMain.SaveOrder;
var
  s:string;
  ls:TRecord_;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if cdsTable.IsEmpty then Raise Exception.Create('没有输入商品，不能进行结账...');
  if ShopGlobal.GetParameter('GUIDE_USER')='0' then
  begin
     if AObj.FieldByName('GUIDE_USER').AsString='' then
        Raise Exception.Create('请输入导购员再结账！');
  end;

  //2011.06.14增加单品限量和本单限量
  CheckSale_Limit;   

  Saved := false;
  Check;
  CheckInvaid;
  Calc;

  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := Global.SHOP_ID;
  AObj.FieldByName('SALES_TYPE').AsInteger := 4;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',now());
  AObj.FieldByName('CHK_USER').AsString := Global.UserID;
  AObj.FieldByName('SALE_AMT').AsFloat := TotalAmt;
  AObj.FieldByName('SALE_MNY').AsFloat := TotalFee;
  if edtREMARK.Text='输入备注按[\]键' then
     AObj.FieldByName('REMARK').AsString := ''
  else
     AObj.FieldByName('REMARK').AsString := edtREMARK.Text;

  if (AObj.FieldByName('BARTER_INTEGRAL').AsFloat<>0) and (AObj.FieldByName('CLIENT_ID').AsString='') then Raise Exception.Create('不是会员消费，不能有积分兑换对商品.');
  Printed := DevFactory.SavePrint;
  //结算对话框
  if not TfrmShowDibs.ShowDibs(self,TotalFee,AObj,Printed,Cash,Dibs,cdsICGlide) then Exit;
  //end
  Factor.BeginBatch;
  cdsTable.DisableControls;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    cdsLocusNo.First;
    while not cdsLocusNo.Eof do cdsLocusNo.Delete;
    ls := TRecord_.Create;
    cdsTable.DisableControls;
    try
    cdsTable.First;
    while not cdsTable.Eof do
       begin
         cdsTable.Edit;
         cdsTable.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
         cdsTable.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
         cdsTable.FieldByName('SALES_ID').AsString := cdsHeader.FieldbyName('SALES_ID').AsString;
         cdsTable.Post;
         if cdsTable.FieldbyName('LOCUS_NO').AsString<>'' then
           begin
             ls.ReadFromDataSet(cdsTable);
             cdsLocusNo.Append;
             ls.WriteToDataSet(cdsLocusNo,false);
             cdsLocusNo.FieldByName('CREA_DATE').AsString := cdsHeader.FieldByName('CREA_DATE').AsString;
             cdsLocusNo.FieldByName('CREA_USER').AsString := cdsHeader.FieldByName('CREA_USER').AsString;
             cdsLocusNo.FieldByName('LOCUS_DATE').AsInteger := cdsHeader.FieldByName('SALES_DATE').AsInteger;
             cdsLocusNo.Post;
           end;
         cdsTable.Next;
       end;
    finally
       cdsTable.EnableControls;
       ls.Free;
    end;
    cdsICGlide.DisableControls;
    try
      cdsICGlide.First;
      while not cdsICGlide.Eof do
        begin
          if cdsICGlide.FieldByName('SALES_ID').AsString='' then
             begin
               cdsICGlide.Edit;
               cdsICGlide.FieldByName('SALES_ID').AsString := cdsHeader.FieldbyName('SALES_ID').AsString;
               cdsICGlide.FieldByName('CREA_DATE').asInteger := cdsHeader.FieldbyName('SALES_DATE').asInteger;
               cdsICGlide.Post;
             end;
          cdsICGlide.Next;
        end;
    finally
      cdsICGlide.EnableControls;
    end;
    Factor.AddBatch(cdsHeader,'TSalesOrder');
    Factor.AddBatch(cdsTable,'TSalesData');
    Factor.AddBatch(cdsLocusNo,'TSalesForLocusNo');
    Factor.AddBatch(cdsICGlide,'TSalesICData');
    Factor.CommitBatch;
    cdsTable.EnableControls;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsTable.EnableControls;
    Raise;
  end;
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\pos.dat');
  AObj.CopyTo(SaveAObj);
  ShowHeader;
  dbState := dsBrowse;

end;

procedure TfrmPosMain.Setoid(const Value: string);
begin
  Foid := Value;
end;

procedure TfrmPosMain.Calc;
var
  r:integer;
  mny1:Currency;
  ago1:Currency;
  mny:Currency;
  ago:Currency;
  prf:Currency;
  t:integer;
  amt:Currency;
  integral:integer;
  ps:TZQuery;
begin
  ps := Global.GetZQueryFromName('PUB_PRICEGRADE');
  if ps.Locate('PRICE_ID',AObj.FieldbyName('PRICE_ID').AsString,[]) then
     begin
       t := ps.FieldbyName('INTE_TYPE').AsInteger;
       amt := ps.FieldbyName('INTE_AMOUNT').asFloat;
     end
  else
     begin
       t := 0;
       amt := 0;
     end;
  cdsTable.DisableControls;
  try
    r := cdsTable.FieldbyName('SEQNO').AsInteger;
    TotalFee := 0;
    TotalBarter := 0;
    TotalAmt := 0;
    mny := 0;
    ago := 0;
    mny1 := 0;
    ago1 := 0;
    prf := 0;
    mny := 0;
    ago := 0;
    STGAMT := 0;
    cdsTable.First;
    while not cdsTable.Eof do
      begin
        TotalFee := TotalFee + cdsTable.FieldbyName('CALC_MONEY').AsFloat;
        TotalAmt := TotalAmt + cdsTable.FieldbyName('AMOUNT').AsFloat;
        mny1 := mny1 + cdsTable.FieldbyName('AMONEY').AsFloat;
        ago1 := ago1 + cdsTable.FieldbyName('AGIO_MONEY').AsFloat;
        if (cdsTable.FieldbyName('HAS_INTEGRAL').AsInteger =1 ) and (cdsTable.FieldbyName('IS_PRESENT').AsInteger=0) then
        begin
        prf := prf + cdsTable.FieldbyName('CALC_MONEY').AsFloat-(cdsTable.FieldbyName('COST_PRICE').AsFloat*cdsTable.FieldbyName('CALC_AMOUNT').AsFloat);
        mny := mny + cdsTable.FieldbyName('AMONEY').AsFloat;
        ago := ago + cdsTable.FieldbyName('AGIO_MONEY').AsFloat;
        end;
        if cdsTable.FieldbyName('IS_PRESENT').AsInteger = 2 then
           TotalBarter := TotalBarter + trunc(cdsTable.FieldbyName('CALC_AMOUNT').AsFloat*cdsTable.FieldbyName('BARTER_INTEGRAL').AsFloat);
        if cdsTable.FieldbyName('GODS_ID').asString=STGID then
           STGAMT := STGAMT + cdsTable.FieldbyName('CALC_AMOUNT').asFloat;
        cdsTable.Next;
      end;
  finally
    cdsTable.Locate('SEQNO',r,[]);
    cdsTable.EnableControls;
  end;
  lblInputHimt.Caption := '库存:'+formatFloat('#0.###',STGAMOUNT)+''+STGNM+' 销售:'+formatFloat('#0.###',STGAMT)+''+STGNM+'  品名:'+STGGNM;
  if (amt<>0) and (dbState<>dsBrowse) then
     begin
       case t of
       1:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(TotalFee / amt);
       2:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(prf / amt);
       3:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(TotalAmt / amt);
       end;
       edtINTEGRAL.Text := AObj.FieldbyName('INTEGRAL').asString;
     end;
  AObj.FieldbyName('BARTER_INTEGRAL').AsInteger := TotalBarter;
  edtAGIO_MONEY.Text := formatFloat('#0.0#',ago1);
  edtAMONEY.Text := formatFloat('#0.0#',mny1);
  lblACCT_MNY.Caption := '结算:'+floattostr(TotalFee-AObj.FieldbyName('PAY_DIBS').asFloat);
end;

procedure TfrmPosMain.Createparams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      //EXStyle:=ExStyle or WS_EX_TOPMOST OR WS_EX_ACCEPTFILES or WS_DLGFRAME ;
      WndParent:= Application.MainForm.Handle;
    end;  
end;

procedure TfrmPosMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key in [ord('P'),ord('p')]) then
     begin
       PostMessage(Handle,WM_EXEC_ORDER,0,3);
     end;
  if (Shift = [ssCtrl]) and (Key in [ord('F'),ord('f')]) then
     begin
       LookOrder;
     end;
  if (Shift = []) and (Key = VK_INSERT) then
     begin
       PostMessage(Handle,WM_EXEC_ORDER,0,2);
     end;
  if (Shift = []) and (Key = VK_PRIOR) then
     begin
       PostMessage(Handle,WM_EXEC_ORDER,0,5);
     end;
  if (Shift = []) and (Key = VK_NEXT) then
     begin
       PostMessage(Handle,WM_EXEC_ORDER,0,6);
     end;
  if (Shift = []) and (Key = VK_F1) then
     begin
       rzHelp.Visible := not rzHelp.Visible;
       rzHelp.Top := RzPanel3.Top + RzPanel3.Height-rzHelp.Height+10;
     end;

  if (Shift = []) and (Key = VK_F2) then
     begin
       if dbState = dsBrowse then Exit;
       OpenDialogTrend;
       Exit;
     end;   

  if (Shift = []) and (Key = VK_F7) then
     begin
       InputFlag := 10;
       if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
       //HangUp;
      // LoadFile('H');
     end;
  if (Shift = []) and (Key = VK_F8) then
     begin
       InputFlag := 11;
       if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
      // PickUp;
      // LoadFile('H');
     end;
     
  if (Shift = []) and (Key = VK_F10) then
     begin
       if dbState = dsBrowse then Exit;
       if cdsTable.IsEmpty then Exit;
       if cdsTable.FieldByName('GODS_ID').AsString = '' then Exit;
       ReturnGods;
     end;
  if (Shift = []) and (Key = VK_F6) then
     begin
       InputFlag := 2;
       if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
     end;
  if (Shift = []) and (Key = VK_PAUSE) then
     begin
       frmMain.FindAction('actfrmLockScreen').OnExecute(nil);
     end;
  if (Shift = []) and (Key=VK_F5) then
     begin
       InputFlag := 1;
       if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
     end;
  if (Shift = []) and (Key=VK_F3) then
     begin
       if cdsTable.FieldbyName('GODS_ID').asString='' then Exit;
       InputFlag := 9;
       if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
     end;
end;

procedure TfrmPosMain.WMExecOrder(var Message: TMessage);
begin
  case Message.LParam of
  0: actSave.OnExecute(actSave);
  1: actDelete.OnExecute(actDelete);
  2: actNew.OnExecute(actNew);
  3: actPrint.OnExecute(actPrint);
//  4: actAudit.OnExecute(actAudit);
  5: actPrior.OnExecute(actPrior);
  6: actNext.OnExecute(actNext);
//  7: actCancel.OnExecute(actCancel);
  8: actFind.OnExecute(actFind);
//  9: actInfo.OnExecute(actInfo);
  10: actPreview.OnExecute(actPreview);
//  11: actEdit.OnExecute(actEdit);
  end;
end;

procedure TfrmPosMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '/' then
     begin
       PopupMenu;
       Key := #0;
     end;
  if Key = '\' then
     begin
       InputFlag := 12;
       Key := #0;
     end;
  if Key = '+' then
     begin
       if cdsTable.IsEmpty then exit;
       PostMessage(Handle,WM_EXEC_ORDER,0,0);
       Key := #0;
     end;
//  inherited;

end;

procedure TfrmPosMain.actNewExecute(Sender: TObject);
begin
  inherited;
  DeleteOrder
end;

procedure TfrmPosMain.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if not cdsTable.IsEmpty then cdsTable.Delete;
end;

procedure TfrmPosMain.actSaveExecute(Sender: TObject);
var c:integer;
begin
  inherited;
  SaveOrder;
  if Saved then
  begin
    try
      if DevFactory.SavePrint and Printed then
       begin
         if DevFactory.PrintFormat=1 then
            DoPrintOrder(oid)
         else
            begin
              for c:=1 to DevFactory.copys do
                DoPrintTicket(inttostr(Global.TENANT_ID),oid,0,Cash,Dibs);
            end;
       end;
    except
      MessageBox(Handle,'打印小票出错，请确定纸张是否安装，小票打印电源是否打开？',pchar(Application.Title),MB_OK+MB_ICONQUESTION);
    end;
    DevFactory.OpenCashBox;
    NewOrder;
    ShowHeader(1);
  end;
end;

procedure TfrmPosMain.actCancelExecute(Sender: TObject);
begin
  inherited;
  CancelOrder;
end;

procedure TfrmPosMain.actPriorExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
  if cdsTable.Changed and not cdsTable.IsEmpty then
     begin
       Raise Exception.Create('当前单据没有结帐，请结帐后再新增');
     end;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := Global.SHOP_ID;
    Params.ParamByName('CREA_USER').asString := Global.UserID;
    Params.ParamByName('SALES_TYPE').asString := '4';
    if (gid = '') or (gid='..新增..') then
       Params.ParamByName('GLIDE_NO').asString := '9999999999999999'
    else
       Params.ParamByName('GLIDE_NO').asString := gid;
    Temp := TZQuery.Create(nil);
    try
       Factor.Open(Temp,'TSalesOrderGetPrior',Params);
       if Temp.Fields[0].asString<>'' then
          Open(Temp.Fields[0].asString);
    finally
       Temp.Free;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmPosMain.actNextExecute(Sender: TObject);
var
  Temp:TZQuery;
  Params:TftParamList;
begin
  inherited;
  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
  if cdsTable.Changed and not cdsTable.IsEmpty then
     begin
       Raise Exception.Create('当前单据没有结帐，请结帐后再新增');
     end;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := Global.SHOP_ID;
    Params.ParamByName('CREA_USER').asString := Global.UserID;
    Params.ParamByName('SALES_TYPE').asString := '4';
    if gid = '' then
       Params.ParamByName('GLIDE_NO').asString := '00000000000000'
    else
       Params.ParamByName('GLIDE_NO').asString := gid;
    Temp := TZQuery.Create(nil);
    try
       Factor.Open(Temp,'TSalesOrderGetNext',Params);
       if Temp.Fields[0].asString<>'' then
          Open(Temp.Fields[0].asString);
    finally
       Temp.Free;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmPosMain.actAuditExecute(Sender: TObject);
begin
  inherited;
  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
  if cdsTable.Changed and not cdsTable.IsEmpty then
     begin
       Raise Exception.Create('当前单据没有结帐，请结帐后再新增');
     end;
  AuditOrder;
end;

procedure TfrmPosMain.DoPrintTicket(cid, id: string; iFlag: integer; cash,
  dibs: Currency);
var PWidth:integer;
  procedure WriteAndEnter(s:string;Len:Integer=0);
    begin
      DevFactory.WritePrint(s);
    end;
  function FormatString(s:string;pWidth:Integer):string;
    var i:Integer;
    begin
      result := '';
      for i:=1 to (pWidth - Length(s)) do Result := ' '+Result;

      Result := Result + s;
    end;
  function FormatText(s:string;pWidth:Integer):string;
    var i:Integer;
    begin
      result := '';
      for i:=1 to (pWidth - Length(s)) do Result := Result +' ';

      Result :=s+ Result ;
    end;
  procedure WirteGodsAndEnter(mc:string;sl,dj,je,org:string);
    var s,vmc:string;
        n,l:integer;
    begin
      s := '';
      if strtofloat(org)<>strtofloat(dj) then
         begin
           if length(org)>=5 then s :=s + ' '+FormatString(org,5)
           else
           s :=s + FormatString(Org,5);
         end;
      if length(dj)>=5 then
         s := s+' '+dj
      else
         s := s+FormatString(dj,5);
      if length(sl)>=5 then
         s := s+' '+sl
      else
         s := s+FormatString(sl,5);
      if length(je)>=6 then s :=s + ' '+FormatString(je,6)
      else
         s := s+FormatString(je,6);
      vmc := StringReplace(mc,'（','(',[rfReplaceAll]);
      vmc := StringReplace(vmc,'）',')',[rfReplaceAll]);
      vmc := StringReplace(vmc,'，',',',[rfReplaceAll]);
      vmc := StringReplace(vmc,'。','.',[rfReplaceAll]);
      vmc := StringReplace(vmc,'：',':',[rfReplaceAll]);
      vmc := StringReplace(vmc,'；',';',[rfReplaceAll]);
      vmc := StringReplace(vmc,'！','!',[rfReplaceAll]);

      n := Length(s); //数字长度
      l := Length(vmc);//品名称长度
      if (n+l+1)>PWidth then
         begin
           WriteAndEnter(vmc);
           WriteAndEnter(FormatString('',PWidth-n-1)+s);
         end
      else
         begin
           WriteAndEnter(FormatText(vmc,PWidth-n-1)+s);
         end;
    end;
    function FormatTitle(s:string):string;
    var i:Integer;
        n:integer;
    begin
        n := (PWidth - length(s)) div 2;
        result := '';
        for i:=1 to n do
           Result := Result + ' ';
        Result := Result + s;
    end;
  function GetPayText(id:string):string;
  var
    rs:TZQuery;
  begin
    rs := Global.GetZQueryFromName('PUB_PAYMENT');
    if rs.Locate('CODE_ID',id,[]) then
       result := rs.FieldbyName('CODE_NAME').AsString
    else
       result := 'id';
    if length(result)<5 then result := result + '支付';
  end;
  function GetTicketGodsName(DataSet:TDataSet):string;
  begin
    case DevFactory.TicketPrintName of
    0:result := DataSet.FieldbyName('GODS_NAME').AsString;
    1:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('GODS_CODE').AsString;
    2:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('BARCODE').AsString;
    3:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
    4:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('GODS_CODE').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
    5:result := DataSet.FieldbyName('GODS_NAME').AsString+' '+DataSet.FieldbyName('BARCODE').AsString+' '+DataSet.FieldbyName('PROPERTY_02_TEXT').AsString+DataSet.FieldbyName('PROPERTY_01_TEXT').AsString;
    else
      result := DataSet.FieldbyName('GODS_NAME').AsString;
    end;
  end;
var
  i,PrintNull:Integer;
  s:string;
  total:Currency;
  rs:TZQuery;
  ls:TStringList;
begin
  if not ShopGlobal.GetChkRight('13100001',9) then  //打印小票权限
     begin
       MessageBox(Handle,'你没有打印小票的权限...','友情提示...',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
//  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
//  if cdsTable.Changed and not cdsTable.IsEmpty then
//    begin
//       Raise Exception.Create('当前单据没有结帐，请结帐后再新增');
//     end;
  if DevFactory.LPT <=0 then Exit;
  PWidth := DevFactory.Width;

  PrintNull := DevFactory.PrintNull;
  DevFactory.BeginPrint;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := PrintSQL(cid,id);
    Factor.Open(rs);
    if iFlag<0 then WriteAndEnter(formatTitle('--整单删除--'));
    WriteAndEnter(formatTitle(DevFactory.Title));
    WriteAndEnter('日期:'+formatFloat('0000-00-00',rs.FieldbyName('SALES_DATE').AsFloat));
    WriteAndEnter('门店:'+rs.FieldbyName('SHOP_NAME').AsString);
    WriteAndEnter('单号:'+rs.FieldbyName('GLIDE_NO').AsString);
    if rs.FieldbyName('CLIENT_CODE').AsString <>'' then
       begin
         WriteAndEnter('客户:'+rs.FieldbyName('CLIENT_CODE').AsString+'('+rs.FieldbyName('CLIENT_NAME').AsString+')');
       end;
    WriteAndEnter('收银员:'+rs.FieldbyName('CREA_USER_TEXT').AsString+'  导购员:'+rs.FieldbyName('GUIDE_USER_TEXT').AsString);
    WriteAndEnter(DevFactory.EncodeDivStr);
    if PWidth=30 then
       begin
         WriteAndEnter('商品     原价 单价 数量  金额');
         WriteAndEnter('-----------------------------');
       end
    else
       begin
         WriteAndEnter('商品           原价 现价 数量  金额');
         WriteAndEnter('-----------------------------------');
       end;
     total := 0;
     rs.First;
     while not rs.Eof do
       begin
         if rs.FieldbyName('CALC_MONEY').AsFloat=0 then
            s := '赠'
         else
            s := rs.FieldbyName('CALC_MONEY').AsString;
         total := total + rs.FieldbyName('CALC_MONEY').AsFloat;
         if rs.FieldbyName('AMOUNT').AsFloat < 0 then
            WirteGodsAndEnter(GetTicketGodsName(rs)+'(退货)',rs.FieldbyName('AMOUNT').AsString+rs.FieldbyName('UNIT_NAME').AsString,rs.FieldbyName('APRICE').asString,s,rs.FieldbyName('ORG_PRICE').asString)
         else
            WirteGodsAndEnter(GetTicketGodsName(rs),rs.FieldbyName('AMOUNT').AsString+rs.FieldbyName('UNIT_NAME').AsString,rs.FieldbyName('APRICE').asString,s,rs.FieldbyName('ORG_PRICE').asString);
         rs.Next;
       end;
     WriteAndEnter(DevFactory.EncodeDivStr);
     if rs.FieldbyName('PAY_DIBS').AsFloat<>0 then
        WriteAndEnter('合计:'+FormatFloat('#0.0##',rs.FieldbyName('SALE_MNY').AsFloat-rs.FieldbyName('PAY_DIBS').AsFloat)+' 抹零:'+FormatFloat('#0.000',rs.FieldbyName('PAY_DIBS').AsFloat))
     else
        WriteAndEnter('合计:'+FormatFloat('#0.0##',rs.FieldbyName('SALE_MNY').AsFloat-rs.FieldbyName('PAY_DIBS').AsFloat));
     WriteAndEnter(DevFactory.EncodeDivStr);
     if rs.FieldbyName('PAY_A').AsFloat <> 0 then
        WriteAndEnter(GetPayText('A')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_A').AsFloat));
     if rs.FieldbyName('PAY_B').AsFloat <> 0 then
        WriteAndEnter(GetPayText('B')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_B').AsFloat));
     if rs.FieldbyName('PAY_C').AsFloat <> 0 then
        WriteAndEnter(GetPayText('C')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_C').AsFloat));
     if rs.FieldbyName('PAY_D').AsFloat <> 0 then
        WriteAndEnter(GetPayText('D')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_D').AsFloat));
     if rs.FieldbyName('PAY_E').AsFloat <> 0 then
        WriteAndEnter(GetPayText('E')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_E').AsFloat));
     if rs.FieldbyName('PAY_F').AsFloat <> 0 then
        WriteAndEnter(GetPayText('F')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_F').AsFloat));
     if rs.FieldbyName('PAY_G').AsFloat <> 0 then
        WriteAndEnter(GetPayText('G')+':'+FormatFloat('#0.0##',rs.FieldbyName('PAY_G').AsFloat));

     if rs.FieldbyName('INTEGRAL').AsFloat <> 0 then
        WriteAndEnter('本单积分:'+rs.FieldbyName('INTEGRAL').AsString);
     if rs.FieldbyName('BARTER_INTEGRAL').AsFloat <> 0 then
        WriteAndEnter('兑换积分:'+rs.FieldbyName('BARTER_INTEGRAL').AsString);
     if rs.FieldbyName('ACCU_INTEGRAL').AsFloat <> 0 then
        WriteAndEnter('累计积分:'+rs.FieldbyName('ACCU_INTEGRAL').AsString);

     WriteAndEnter(DevFactory.EncodeDivStr);
     if rs.FieldbyName('CASH_MNY').AsFloat <> 0 then
        begin
          WriteAndEnter('实收:'+FormatFloat('#0.0##',rs.FieldbyName('CASH_MNY').AsFloat)+'  找零:'+FormatFloat('#0.0##',rs.FieldbyName('PAY_ZERO').AsFloat));
          WriteAndEnter(DevFactory.EncodeDivStr);
        end;
     if DevFactory.Footer <> '' then
        begin
          ls := TStringList.Create;
          try
            ls.Text := DevFactory.Footer;
            for i:=0 to ls.Count -1 do
              WriteAndEnter(ls[i]);
          finally
            ls.Free;
          end;
        end;

     for i:=1 to PrintNull do
        WriteAndEnter('  ',PWidth);
  finally
    CloseFile(DevFactory.F);
    rs.Free;
  end;
end;

procedure TfrmPosMain.actPrintExecute(Sender: TObject);
begin
  inherited;
  if (oid='') or (dbState = dsInsert) then
     begin
       if MessageBox(Handle,'是否打印最近一张销售单?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
          begin
            actPrior.OnExecute(nil);
          end else Exit;
     end;
  if oid<>'' then
     begin
       if DevFactory.PrintFormat=1 then
          DoPrintOrder(oid)
       else
          DoPrintTicket(inttostr(Global.TENANT_ID),oid,0,Cash,Dibs);
       NewOrder;
     end;
end;

function TfrmPosMain.PrintSQL(tenantid, id: string): string;
begin
  result :=
   'select j.*,case when j.IS_PRESENT=2 then ''(兑换)'' when j.IS_PRESENT=1 then ''(赠送)'' else '''' end as IS_PRESENT_TEXT ,'+
   '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+') as TOTAL_OWE_MNY,'+
   '(select sum(RECK_MNY) from ACC_RECVABLE_INFO where CLIENT_ID=j.CLIENT_ID and TENANT_ID='+tenantid+' and SALES_ID='''+id+''') as ORDER_OWE_MNY,'+
   'case when j.INVOICE_FLAG=1 then ''收款收据'' when j.INVOICE_FLAG=2 then ''普通发票'' else ''增值税票'' end as INVOICE_FLAG_TEXT '+
   'from ('+
   'select jn.*,n.DEPT_NAME as DEPT_ID_TEXT from ('+
   'select jm.*,m.CODE_NAME as SETTLE_CODE_TEXT from ( '+
   'select jl.*,l.CODE_NAME as SALES_STYLE_TEXT from ( '+
   'select jk.*,k.UNIT_NAME from ('+
   'select jj.*,j.COLOR_NAME as PROPERTY_02_TEXT from ('+
   'select ji.*,i.SIZE_NAME as PROPERTY_01_TEXT from ('+
   'select jh.*,h.GODS_NAME,h.GODS_CODE,h.BARCODE from ('+
   'select jg.*,g.SHOP_NAME,g.ADDRESS as SHOP_ADDR,g.TELEPHONE as SHOP_TELE,g.FAXES from ('+
   'select jf.*,f.USER_NAME as CREA_USER_TEXT from ('+
   'select je.*,e.GLIDE_NO as GLIDE_NO_FROM from ('+
   'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
   'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
   'select jb.*,b.CLIENT_NAME,b.CLIENT_CODE,b.SETTLE_CODE,b.ADDRESS,b.POSTALCODE,b.TELEPHONE2 as MOVE_TELE,b.INTEGRAL as ACCU_INTEGRAL,b.FAXES as CLIENT_FAXES from ('+
   'select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,A.PLAN_DATE,A.LINKMAN,A.TELEPHONE,A.SEND_ADDR,A.CLIENT_ID,A.CREA_USER,A.GUIDE_USER,'+
   'A.CHK_DATE,A.CHK_USER,A.FROM_ID,A.FIG_ID,A.SALE_AMT,A.SALE_MNY,A.CASH_MNY,A.PAY_ZERO,A.PAY_DIBS,A.PAY_A,A.PAY_B,A.PAY_C,A.PAY_D,'+
   'A.PAY_E,A.PAY_F,A.PAY_G,A.PAY_H,A.PAY_I,A.PAY_J,A.INTEGRAL,A.REMARK,A.INVOICE_FLAG,A.TAX_RATE,A.CREA_DATE,A.SALES_STYLE,'+
   'B.AMOUNT,B.APRICE,B.SEQNO,B.ORG_PRICE,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID,B.BATCH_NO,B.LOCUS_NO,B.GODS_ID,B.CALC_MONEY,A.BARTER_INTEGRAL,B.AGIO_RATE,B.AGIO_MONEY,B.IS_PRESENT,B.REMARK as REMARK_DETAIL from SAL_SALESORDER A,SAL_SALESDATA B '+
   'where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+tenantid+' and A.SALES_ID='''+id+''' ) jb '+
   'left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
   'left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
   'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
   'left outer join SAL_INDENTORDER e on je.TENANT_ID=e.TENANT_ID and je.FROM_ID=e.INDE_ID ) jf '+
   'left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.CREA_USER=f.USER_ID ) jg '+
   'left outer join CA_SHOP_INFO g on jg.TENANT_ID=g.TENANT_ID and jg.SHOP_ID=g.SHOP_ID ) jh '+
   'left outer join VIW_GOODSINFO h on jh.TENANT_ID=h.TENANT_ID and jh.GODS_ID=h.GODS_ID ) ji '+
   'left outer join VIW_SIZE_INFO i on ji.TENANT_ID=i.TENANT_ID and ji.PROPERTY_01=i.SIZE_ID ) jj '+
   'left outer join VIW_COLOR_INFO j on jj.TENANT_ID=j.TENANT_ID and  jj.PROPERTY_02=j.COLOR_ID ) jk '+
   'left outer join VIW_MEAUNITS k on jk.TENANT_ID=k.TENANT_ID and jk.UNIT_ID=k.UNIT_ID ) jl  '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''2'' and TENANT_ID='+tenantid+') l on jl.SALES_STYLE=l.CODE_ID) jm '+
   'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE=''6'' and TENANT_ID='+tenantid+') m on jm.SETTLE_CODE=m.CODE_ID) jn '+
   'left outer join CA_DEPT_INFO n on jn.TENANT_ID=n.TENANT_ID and jn.DEPT_ID=n.DEPT_ID ) j order by SEQNO';
end;

procedure TfrmPosMain.cdsTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not cdsTable.ControlsDisabled then
     begin
       SaveToFile;
       Calc;
     end;
end;

procedure TfrmPosMain.OpenDialogGuide;
var
  SObj:TRecord_;
  SQL:string;
begin
  if dbState = dsBrowse then Exit;
  SObj := TRecord_.Create;
  try
    SQL := 'select 0 as A,USER_ID,USER_SPELL,USER_NAME,ACCOUNT from VIW_USERS where COMM not in (''02'',''12'') and TENANT_ID='+inttostr(Global.TENANT_ID);
    if TframeListDialog.FindDialog(self,SQL,'ACCOUNT=帐号,USER_NAME=姓名,USER_SPELL=拼音码',SObj) then
       begin
         AObj.FieldbyName('GUIDE_USER').AsString := SObj.FieldbyName('USER_ID').AsString;
         AObj.FieldbyName('GUIDE_USER_TEXT').AsString := SObj.FieldbyName('USER_NAME').AsString;
         ShowHeader;
       end;
  finally
    SObj.Free;
  end;

end;

procedure TfrmPosMain.fndBARCODEEnter(Sender: TObject);
begin
  inherited;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.fndCLIENT_CODEEnter(Sender: TObject);
begin
  inherited;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.rckPAY_1Enter(Sender: TObject);
begin
  inherited;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.ShowHeader(flag:integer=0);
var slbl:string;
procedure ShowPay(flag:integer;value:Currency;lbl:string);
begin
 case flag of
 1:begin
     lblPAY_1.Caption := lbl+'支付';
     rckPAY_1.Text := formatFloat('#0.0#',value);
     lblPAY_1.Visible := true;
     rckPAY_1.Visible := true;
   end;
 2:begin
     lblPAY_2.Caption := lbl+'支付';
     rckPAY_2.Text := formatFloat('#0.0#',value);
     lblPAY_2.Visible := true;
     rckPAY_2.Visible := true;
   end;
 3:begin
     lblPAY_3.Caption := lbl+'支付';
     rckPAY_3.Text := formatFloat('#0.0#',value);
     lblPAY_3.Visible := true;
     rckPAY_3.Visible := true;
   end;
 4:begin
     lblPAY_4.Caption := lbl+'支付';
     rckPAY_4.Text := formatFloat('#0.0#',value);
     lblPAY_4.Visible := true;
     rckPAY_4.Visible := true;
   end;
 end;
end;
function GetIdle:string;
var
  i:integer;
begin
  for i:=10 TO 20 do
    begin
      result := inttohex(i,1);
      if pos(result,slbl)<=0 then
         begin
           slbl := slbl + result;
           break;
         end;
    end;
end;
var
  pid:string;
  n,i:integer;
  MyAObj:TRecord_;
begin
  agioLower := 0;
  RzGroupBox1.tag := flag;
  if flag=0 then
  begin
    RzGroupBox1.Caption := '结算';
    fndCLIENT_ID_TEXT.Text := AObj.FieldbyName('CLIENT_ID_TEXT').AsString;
    fndGLIDE_NO.Text := AObj.FieldbyName('GLIDE_NO').AsString;
    fndCREA_USER.Text := AObj.FieldbyName('CREA_USER_TEXT').AsString;
    fndGUIDE_USER.Text := AObj.FieldbyName('GUIDE_USER_TEXT').AsString;
    fndCLIENT_CODE.Text := AObj.FieldbyName('CLIENT_CODE').AsString;
    fndCLIENT_ID_TEXT.Text := AObj.FieldbyName('CLIENT_ID_TEXT').AsString;
    fndBALANCE.Text := AObj.FieldbyName('BALANCE').AsString;
    edtREMARK.Text := AObj.FieldbyName('REMARK').AsString;
    if edtREMARK.Text='' then edtREMARK.Text := '输入备注按[\]键';
    fndCREA_DATE.Text := StringReplace(AObj.FieldbyName('CREA_DATE').AsString,'-','',[rfReplaceAll]);
    if AObj.FieldbyName('PRICE_ID').AsString='' then
       fndPRICE_ID.Text := ''
    else
       fndPRICE_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PRICEGRADE'),'PRICE_ID','PRICE_NAME',AObj.FieldbyName('PRICE_ID').AsString);
    edtINTEGRAL.Text := AObj.FieldbyName('INTEGRAL').AsString;
    if edtINTEGRAL.Text='' then edtINTEGRAL.Text := '0';
    fndACCU_INTEGRAL.Text := AObj.FieldbyName('ACCU_INTEGRAL').AsString;
    if fndACCU_INTEGRAL.Text='' then fndACCU_INTEGRAL.Text := '0';
    if AObj.FieldbyName('SALES_DATE').AsString='' then
      fndSALES_DATE.Text := ''
    else
      fndSALES_DATE.Text := formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(AObj.FieldbyName('SALES_DATE').AsString));
    AObj.FieldbyName('CASH_MNY').asFloat := 0;
    AObj.FieldbyName('PAY_ZERO').asFloat := 0;
  end
  else
    RzGroupBox1.Caption := '上单结算';
  MyAObj := AObj;
  if flag=1 then AObj := SaveAObj;
  try
  priPAY_DIBS.Text := AObj.FieldbyName('PAY_DIBS').AsString;
  lblACCT_MNY.Caption := '结算:'+ FloattoStr(
                     AObj.FieldbyName('SALE_MNY').asFloat-AObj.FieldbyName('PAY_DIBS').asFloat) ;
//  lblCASH.Visible := (AObj.FieldbyName('CASH_MNY').asString<>'');
  lblCASH.Caption := '现金:'+floattostr(AObj.FieldbyName('CASH_MNY').asFloat);
//  lblDIBS.Visible := (AObj.FieldbyName('PAY_ZERO').asString<>'');
  lblDIBS.Caption := '找零:'+floattostr(AObj.FieldbyName('PAY_ZERO').asFloat);
//  lblPAY_1.Visible := false;
//  rckPAY_1.Visible := false;
//  lblPAY_2.Visible := false;
//  rckPAY_2.Visible := false;
//  lblPAY_3.Visible := false;
//  rckPAY_3.Visible := false;
//  lblPAY_4.Visible := false;
//  rckPAY_4.Visible := false;
  n := 0;
  if AObj.FieldbyName('PAY_A').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'A';
       ShowPay(n,AObj.FieldbyName('PAY_A').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','A'));
     end;
  if AObj.FieldbyName('PAY_B').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'B';
       ShowPay(n,AObj.FieldbyName('PAY_B').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','B'));
     end;
  if AObj.FieldbyName('PAY_C').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'C';
       ShowPay(n,AObj.FieldbyName('PAY_C').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','C'));
     end;
  if AObj.FieldbyName('PAY_D').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'D';
       ShowPay(n,AObj.FieldbyName('PAY_D').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','D'));
     end;
  if AObj.FieldbyName('PAY_E').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'E';
       ShowPay(n,AObj.FieldbyName('PAY_E').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','E'));
     end;
  if AObj.FieldbyName('PAY_F').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'F';
       ShowPay(n,AObj.FieldbyName('PAY_F').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','F'));
     end;
  if AObj.FieldbyName('PAY_G').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'G';
       ShowPay(n,AObj.FieldbyName('PAY_G').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','G'));
     end;
  if AObj.FieldbyName('PAY_H').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'H';
       ShowPay(n,AObj.FieldbyName('PAY_H').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','H'));
     end;
  if AObj.FieldbyName('PAY_I').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'I';
       ShowPay(n,AObj.FieldbyName('PAY_I').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','I'));
     end;
  if AObj.FieldbyName('PAY_J').asFloat<>0 then
     begin
       inc(n);
       slbl := slbl + 'J';
       ShowPay(n,AObj.FieldbyName('PAY_J').asFloat,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME','J'));
     end;
   for i:=n+1 to 4 do
   begin
     ShowPay(i,0,TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_PAYMENT'),'CODE_ID','CODE_NAME',GetIdle));
   end;
  finally
     AObj := MyAObj;
  end;
end;

procedure TfrmPosMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Application.MainForm.Visible := true;
  inherited;
  Action := cafree;
end;

procedure TfrmPosMain.HangUp;
var
  s:string;
  mm:TMemoryStream;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if dbState = dsEdit then Raise Exception.Create('修改单据状态不能挂单...');
  if cdsTable.IsEmpty then Raise Exception.Create('不能保存挂一张空单据...');
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := Global.SHOP_ID;
  AObj.FieldByName('SALES_TYPE').AsInteger := 4;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldByName('SALE_AMT').AsFloat := TotalAmt;
  AObj.FieldByName('SALE_MNY').AsFloat := TotalFee;

  cdsTable.DisableControls;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    cdsTable.First;
    while not cdsTable.Eof do
       begin
         cdsTable.Edit;
         cdsTable.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
         cdsTable.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
         cdsTable.FieldByName('SALES_ID').AsString := cdsHeader.FieldbyName('SALES_ID').AsString;
         cdsTable.Post;
         cdsTable.Next;
       end;
    s := formatDatetime('YYYY年MM月DD日 HH时NN分SS秒',now());
    ForceDirectories(ExtractFilePath(ParamStr(0))+'HangUp');
    mm := TMemoryStream.Create;
    try
      mm.Clear;
      cdsHeader.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'HangUp\H'+s+'.dat');
      mm.Clear;
      cdsTable.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'HangUp\D'+s+'.dat');
    finally
      mm.Free;
    end;
    cdsTable.EnableControls;
  except
    cdsTable.EnableControls;
    Raise;
  end;
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\pos.dat');
  dbState := dsBrowse;
  MessageBox(Handle,'挂单成功，取单请按/键->9键',pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  NewOrder;
  LoadFile('H');
end;

procedure TfrmPosMain.PickUp;
var
  s:string;
  mm:TMemoryStream;
begin
  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
  if cdsTable.Changed and not cdsTable.IsEmpty then Raise Exception.Create('请先结帐当前单据,再执行取单操作...');
  with TfrmHangUpFile.Create(self) do
    begin
      try
        LoadFile('H');
        if cdsTable.RecordCount = 1 then
           s := cdsTable.FieldbyName('FILENAME').AsString
        else
           begin
             if ShowModal=MROK then
                begin
                   s := cdsTable.FieldbyName('FILENAME').AsString
                end
             else
                Exit;
           end;
      finally
        free;
      end;
    end;
  NewOrder;
  mm := TMemoryStream.Create;
  try
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'HangUp\'+s);
    cdsHeader.LoadFromStream(mm);
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'HangUp\D'+copy(s,2,255));
    cdsTable.LoadFromStream(mm); 
  finally
    mm.Free;
  end;
  AObj.ReadFromDataSet(cdsHeader);
  ShowHeader;
  dbState := dsInsert;
  cdsTable.Last;
  RowId := cdsTable.FieldbyName('SEQNO').AsInteger;
  DeleteFile(ExtractFilePath(ParamStr(0))+'HangUp\'+s);
  DeleteFile(ExtractFilePath(ParamStr(0))+'HangUp\D'+copy(s,2,255));
  Calc;
  LoadFile('H');
end;

procedure TfrmPosMain.Check;
begin
  cdsTable.DisableControls;
  try
    cdsTable.First;
    while not cdsTable.Eof do
      begin
        if cdsTable.FieldbyName('AMOUNT').AsFloat=0 then Raise Exception.Create('请正确输入商品数量...'); 
        cdsTable.Next;
      end;
  finally
    cdsTable.EnableControls;
  end;
end;

procedure TfrmPosMain.Setgid(const Value: string);
begin
  Fgid := Value;
end;

procedure TfrmPosMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
  if cdsTable.Changed and not cdsTable.IsEmpty then
     begin
       CanClose := false;
       MessageBox(Handle,'当前单据没有结帐，请结帐后再关闭电子收款机',pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
     end;

end;

procedure TfrmPosMain.OpenDialogPrice;
var
  r:Currency;
  Params:TLoginParam;
  allow :boolean;
begin
  if cdsTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');
  //2011.06.08 Add 供应链限制改价：
  if CheckNotChangePrice(cdsTable.fieldbyName('GODS_ID').AsString) then Raise Exception.Create('商品〖'+cdsTable.FieldByName('GODS_NAME').AsString+'〗不允许调价销售！');
  if not ShopGlobal.GetChkRight('13100001',5) then  //调价权限
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('13100001',5,Params.UserID);
            if not allow then Raise Exception.Create('输入的用户没有调价权限');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
    if dbState = dsBrowse then Exit;
    r := TfrmPosPrice.PosPrice(self,Deci,cdsTable.FieldbyName('ORG_PRICE').AsFloat,cdsTable.FieldbyName('AGIO_RATE').AsFloat,cdsTable.FieldbyName('APRICE').AsFloat);
    if r>=0 then
       PriceToGods(floattostr(r));
  end;
end;

procedure TfrmPosMain.PresentToGods;
var
  r:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
  s:string;
  Field:TField;
begin
  if cdsTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');
  Field := cdsTable.FindField('APRICE');
  if Field=nil then Exit;
  if Field.AsFloat <> 0 then
  begin
    if not ShopGlobal.GetChkRight('13100001',6) then  //赠送权限
       begin
         if TfrmLogin.doLogin(Params) then
            begin
              allow := ShopGlobal.GetChkRight('13100001',6,Params.UserID);
              if not allow then Raise Exception.Create('输入的用户没有增送权限');
            end
         else
            allow := false;
       end else allow := true;
    if allow then
    begin
      if cdsTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');
      cdsTable.Edit;
      Field.AsFloat := 0;
      PriceToCalc(Field.AsFloat);
    end;
  end
  else
  begin
    InitPrice(cdsTable.FieldbyName('GODS_ID').AsString,cdsTable.FieldbyName('UNIT_ID').AsString);
    PriceToCalc(cdsTable.FieldbyName('APRICE').AsFloat);
  end;
end;

procedure TfrmPosMain.SetInputMode(const Value: integer);
begin
  FInputMode := Value;
end;

procedure TfrmPosMain.CalcPrice;
var r:integer;
begin
  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
  r := cdsTable.RecNo;
  cdsTable.DisableControls;
  try
    cdsTable.First;
    while not cdsTable.Eof do
      begin
        if (cdsTable.FieldbyName('BOM_ID').AsString = '') and (cdsTable.FieldByName('POLICY_TYPE').AsInteger<>4) then
        begin
          InitPrice(cdsTable.FieldbyName('GODS_ID').AsString,cdsTable.FieldbyName('UNIT_ID').AsString,true);
          PriceToCalc(cdsTable.FieldbyName('APrice').asFloat);
        end;
        cdsTable.Next;
      end;
  finally
    if r>0 then cdsTable.RecNo := r;
    cdsTable.EnableControls;
  end;
end;

procedure TfrmPosMain.LoadFile(cName: string);
var
  sr: TSearchRec;
  FileAttrs: Integer;
  i:integer;
begin
  i:=0;
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(ExtractFilePath(ParamStr(0))+'HangUp\*.dat', FileAttrs, sr) = 0 then
    begin
      repeat
        if (sr.Attr and FileAttrs) = sr.Attr then
          begin
          if (copy(sr.Name,1,length(cName))=cName) then
             begin
               i:=i+1;
             end;
          end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  RzStatusPane3.Caption:='挂单[ '+IntToStr(i)+' ]笔';
end;

function TfrmPosMain.EnCodeBarcode: string;
var b:string;
  pbar:TZQuery;
begin
  pbar := Global.GetZQueryFromName('PUB_BARCODE'); 
  basInfo.Filtered := false;
  if basInfo.Locate('GODS_ID',cdsTable.FieldbyName('GODS_ID').AsString,[]) then
     begin
       if (basInfo.FieldbyName('CALC_UNITS').asString=cdsTable.FieldbyName('UNIT_ID').asString)
          and
          (cdsTable.FieldbyName('PROPERTY_01').asString='#')
          and
          (cdsTable.FieldbyName('PROPERTY_02').asString='#')
       then
          b := basInfo.FieldbyName('BARCODE').asString
       else
          begin
            if pbar.Locate('GODS_ID,UNIT_ID,PROPERTY_01,PROPERTY_02',VarArrayOf([cdsTable.FieldbyName('GODS_ID').asString,cdsTable.FieldbyName('UNIT_ID').asString,cdsTable.FieldbyName('PROPERTY_01').asString,cdsTable.FieldbyName('PROPERTY_02').asString]),[]) then
               b := pbar.FieldbyName('BARCODE').asString
            else
            if pbar.Locate('GODS_ID,UNIT_ID',VarArrayOf([cdsTable.FieldbyName('GODS_ID').asString,cdsTable.FieldbyName('UNIT_ID').asString]),[]) then
               b := pbar.FieldbyName('BARCODE').asString
            else
               b := basInfo.FieldbyName('BARCODE').asString;
          end;
       //if (b='') and (basInfo.FieldbyName('BCODE').asString<>'') then
       //   b := GetBarCode(basInfo.FieldbyName('BCODE').asString,'#','#');
     end
  else
     b := '';
  result := b;
end;

procedure TfrmPosMain.ReturnGods;
var
  r:Currency;
  Params:TLoginParam;
  allow :boolean;
begin
  if not ShopGlobal.GetChkRight('13100001',8) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('13100001',8,Params.UserID);
            if not allow then Raise Exception.Create('输入的用户没有退货权限');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
    cdsTable.Edit;
    cdsTable.FieldByName('AMOUNT').AsFloat := - cdsTable.FieldByName('AMOUNT').AsFloat;
    AMountToCalc(cdsTable.FieldByName('AMOUNT').AsFloat);
  end;
end;

function TfrmPosMain.GetCostPrice(SHOP_ID, GODS_ID,
  BATCH_NO: string): Currency;
var
  rs:TZQuery;
  bs:TZQuery;
begin
  rs:=TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select AMONEY,AMOUNT from ('+
      'select sum(AMONEY) as AMONEY,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID and BATCH_NO=:BATCH_NO ) j where AMOUNT<>0';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('GODS_ID').AsString := GODS_ID;
    rs.ParamByName('BATCH_NO').AsString := BATCH_NO;
    Factor.Open(rs);
    if rs.IsEmpty then
       begin
         bs := Global.GetZQueryFromName('PUB_GOODSINFO');
         if bs.Locate('GODS_ID',GODS_ID,[]) then
            result := bs.FieldbyName('NEW_INPRICE').AsFloat
         else
            Raise Exception.Create('没找到经营商品');
       end
    else
       result := rs.Fields[0].AsFloat/rs.Fields[1].AsFloat;
  finally
    rs.Free;
  end;
end;

function TfrmPosMain.GodsToBatchNo(id: string): boolean;
var
  rs,bs:TZQuery;
  AObj:TRecord_;
  r:boolean;
  pt:integer;
begin
  if cdsTable.FieldByName('GODS_ID').AsString = '' then
     begin
       result := true;
       MessageBox(Handle,pchar('请输入商品后再输入批号.'),'友情提示...',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  if id = '' then Raise Exception.Create('输入的批号无效'); 
  result := false;
  rs := TZQuery.Create(nil);
  AObj := TRecord_.Create;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  try
    rs.SQL.Text := 'select max(BATCH_NO) from STO_STORAGE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+Global.SHOP_ID+''' and GODS_ID='''+cdsTable.FieldbyName('GODS_ID').AsString+''' and BATCH_NO='''+id+'''';
    Factor.Open(rs);
    if rs.Fields[0].asString='' then
       begin
         if not bs.Locate('GODS_ID',cdsTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('在经营品牌中没找到.');
         if bs.FieldbyName('USING_BATCH_NO').asInteger<>1 then Raise Exception.Create('当前商品没有启用批号管制...');
         if MessageBox(Handle,'当前门店没有此批号的商品,是否强制手工输入?','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       end;
    cdsTable.Edit;
    cdsTable.FieldbyName('BATCH_NO').asString := id;
    result := true;
  finally
    AObj.Free;
    rs.Free;
  end;
end;

function TfrmPosMain.GodsToLocusNo(id: string): boolean;
var
  rs,bs:TZQuery;
  AObj:TRecord_;
  pt:integer;
  r:boolean;
begin
  if id = '' then Raise Exception.Create('输入的物流跟踪号无效');
  result := false;
  rs := TZQuery.Create(nil);
  AObj := TRecord_.Create;
  try
    rs.SQL.Text :=
      'select j.* from ('+
      'select distinct A.GODS_ID,A.LOCUS_NO,A.UNIT_ID,A.BATCH_NO,A.AMOUNT,0 as IS_PRESENT,B.GODS_CODE,B.GODS_NAME,B.BARCODE from STK_LOCUS_FORSTCK A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.SHOP_ID='''+Global.SHOP_ID+''' and A.LOCUS_NO='''+id+''' ) j';
    Factor.Open(rs);
    if rs.IsEmpty and (ShopGlobal.GetParameter('LOCUS_NO_MT')<>'1') then
       begin
         Raise Exception.Create('无效的物流跟踪号:'+id);
       end;
    if rs.RecordCount > 1 then
       begin
         if TframeListDialog.FindDialog(self,rs.SQL.Text,'GODS_CODE=货号,GODS_NAME=商品名称,BATCH_NO=批号,BARCODE=条码',AObj) then
            begin
            end
         else
            Exit;
       end
    else
    if rs.RecordCount =0 then
       begin
         if MessageBox(Handle,'当前物流跟踪码没有入库，是否强制手工出库？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
         bs := Global.GetZQueryFromName('PUB_GOODSINFO');
         if not bs.Locate('GODS_ID',cdsTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('在经营品牌中没找到.');
         if bs.FieldbyName('USING_LOCUS_NO').asInteger<>1 then Raise Exception.Create('当前商品没有启用物流跟踪码...');
         AObj.ReadFromDataSet(cdsTable);
         AObj.FieldbyName('LOCUS_NO').asString := id;
       end
    else
       AObj.ReadFromDataSet(rs);
     pt := AObj.FieldbyName('IS_PRESENT').AsInteger;

     r := cdsTable.Locate('GODS_ID;BATCH_NO;UNIT_ID;IS_PRESENT;LOCUS_NO,BOM_ID',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,AObj.FieldbyName('BATCH_NO').AsString,AObj.FieldbyName('UNIT_ID').AsString,pt,AObj.FieldbyName('LOCUS_NO').AsString,null]),[]);
     if not r then
     begin
        if (cdsTable.FieldbyName('GODS_ID').asString=AObj.FieldbyName('GODS_ID').AsString) and (cdsTable.FieldbyName('LOCUS_NO').asString='')
        then
           cdsTable.Edit
        else
           begin
             inc(RowID);
             cdsTable.Append;
             cdsTable.FieldbyName('SEQNO').asInteger := RowID;
           end;
        cdsTable.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
        cdsTable.FieldbyName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
        cdsTable.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
        cdsTable.FieldByName('IS_PRESENT').asInteger := pt;
        cdsTable.FieldbyName('UNIT_ID').AsString := AObj.FieldbyName('UNIT_ID').AsString;
        cdsTable.FieldbyName('BATCH_NO').AsString := AObj.FieldbyName('BATCH_NO').AsString;
        cdsTable.FieldbyName('LOCUS_NO').AsString := AObj.FieldbyName('LOCUS_NO').AsString;
        cdsTable.FieldbyName('BOM_ID').Value := null;
        cdsTable.FieldbyName('BARCODE').AsString := EncodeBarcode;
        cdsTable.FieldbyName('PROPERTY_01').AsString := '#';
        cdsTable.FieldbyName('PROPERTY_02').AsString := '#';
        InitPrice(AObj.FieldbyName('GODS_ID').AsString,AObj.FieldbyName('UNIT_ID').AsString);
     end else Raise Exception.Create('当前物流跟踪号已经输入，不能重复输入,跟踪号为:'+id);
     WriteAmount(AObj.FieldbyName('AMOUNT').asFloat,true);
     result := false;
  finally
    AObj.Free;
    rs.Free;
  end;
end;

procedure TfrmPosMain.PopupMenu;
var CardNo:String;
begin
  case TfrmPosMenu.ShowMenu(self) of
  0:case TfrmCloseForDay.ShowClDy(self) of
    1:Close;
    2:Close;
    end;
  1:begin
    LookOrder;
  end;
  2:begin
    if not ShopGlobal.GetChkRight('33400001',2) then Raise Exception.Create('你没有新增"会员档案"的权限,请和管理员联系.');
    With TfrmCustomerInfo.Create(self) do
    begin
      try
        Append;
        if ShowModal = mrOk then
          CardNo := AObj.FieldbyName('CUST_CODE').AsString
        else
          CardNo := '';
      finally
        Free;
      end;
    end;
    if CardNo <> '' then
      WriteInfo(CardNo);
  end;
  3:begin
    if not ShopGlobal.GetChkRight('33500001',3) then Raise Exception.Create('你没有"发卡"的权限,请和管理员联系.');
    if AObj.FindField('CLIENT_ID')=nil then NewOrder;
    if AObj.FieldByName('CLIENT_ID').AsString = '' then
      begin
        if OpenDialogCustomer('',2) then
          begin
            NewCardExecute;
          end;
      end
    else
      NewCardExecute;
  end;
  4:begin
    if not ShopGlobal.GetChkRight('33500001',4) then Raise Exception.Create('你没有"充值"的权限,请和管理员联系.');
    if AObj.FindField('CLIENT_ID')=nil then NewOrder;
    if AObj.FieldByName('CLIENT_ID').AsString = '' then
      begin
        if OpenDialogCustomer('',2) then
          begin
            DepositExecute;
          end;
      end
    else
      DepositExecute;
  end;
  5:begin
    if not ShopGlobal.GetChkRight('33500001',5) then Raise Exception.Create('你没有"退款"的权限,请和管理员联系.');
    if AObj.FindField('CLIENT_ID')=nil then NewOrder;
    if AObj.FieldByName('CLIENT_ID').AsString = '' then
      begin
        if OpenDialogCustomer('',2) then
          begin
            ReturnExecute;
          end;
      end
    else
      ReturnExecute;
  end;
  6:begin
    if not ShopGlobal.GetChkRight('33500001',6) then Raise Exception.Create('你没有"挂失卡"的权限,请和管理员联系.');
    if AObj.FindField('CLIENT_ID')=nil then NewOrder;
    if AObj.FieldByName('CLIENT_ID').AsString = '' then
      begin
        if OpenDialogCustomer('',2) then
          begin
            LossCardExecute;
          end;
      end
    else
      LossCardExecute;
  end;
  7:begin
    if AObj.FindField('CLIENT_ID')=nil then NewOrder;
    if AObj.FieldByName('CLIENT_ID').AsString = '' then
      begin
        if OpenDialogCustomer('',2) then
          begin
            PasswordExecute;
          end;
      end
    else
      PasswordExecute;
  end;
  8:HangUp;
  9:PickUp;
  9999999:;
  else
    Raise Exception.Create('暂时不支持此项功能...'); 
  end;

end;

procedure TfrmPosMain.CheckInvaid;
var
  bs:TZQuery;
  r:integer;
begin
  if cdsTable.State in [dsEdit,dsInsert] then cdsTable.Post;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  r := cdsTable.RecNo;
  cdsTable.DisableControls;
  try
    cdsTable.First;
    while not cdsTable.eof do
      begin
        if not bs.Locate('GODS_ID',cdsTable.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create(cdsTable.FieldbyName('GODS_NAME').asString+'在经营商品中没有找到.');
        if (bs.FieldByName('USING_BATCH_NO').AsString = '1') and (cdsTable.FieldbyName('BATCH_NO').AsString='#') then Raise Exception.Create(cdsTable.FieldbyName('GODS_NAME').asString+'商品必须输入商品批号。');
//        if (bs.FieldByName('USING_LOCUS_NO').AsString = '1') and (cdsTable.FieldbyName('LOCUS_NO').AsString='') then Raise Exception.Create(cdsTable.FieldbyName('GODS_NAME').asString+'商品必须输入商品物流跟踪号。');
        cdsTable.Next;
      end;
    if r>0 then cdsTable.RecNo := r;
  finally
    cdsTable.EnableControls;
  end;
end;

procedure TfrmPosMain.RzStatusPane3Click(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,'是否执行取单操作.','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  PickUp;
end;

procedure TfrmPosMain.edtInputPropertiesChange(Sender: TObject);
var s:string;
begin
  inherited;
  if (InputFlag=0) and (InputMode=1) then
     begin
       s := trim(edtInput.Text);
       DBGridEh2.Visible := (s<>'') and (s[1]<>'=');
       if not DBGridEh2.Visible then Exit;
       basInfo.OnFilterRecord := BasInfoFilterRecord;
       try
         basInfo.Filtered := false;
         basInfo.Filtered := true;
       finally
       end;
     end;
end;

procedure TfrmPosMain.BasInfoFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept :=
    (pos(edtInput.Text,DataSet.FieldbyName('GODS_CODE').AsString)>0);
  if not Accept then
  Accept := (pos(edtInput.Text,DataSet.FieldbyName('BARCODE').AsString)>0);
  if not Accept then
  Accept := (pos(lowercase(edtInput.Text),lowercase(DataSet.FieldbyName('GODS_SPELL').AsString))>0);
  if not Accept then
  Accept := (pos(edtInput.Text,DataSet.FieldbyName('GODS_NAME').AsString)>0);

end;

procedure TfrmPosMain.RzStatusPane5Click(Sender: TObject);
begin
  inherited;
  if cdsTable.Changed and not cdsTable.IsEmpty then
     begin
       MessageBox(Handle,'当前单据没有结帐，请结帐后再关闭电子收款机',pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  case TfrmCloseForDay.ShowClDy(self) of
    1:Close;
    2:Close;
  end;
end;

procedure TfrmPosMain.RzStatusPane7Click(Sender: TObject);
begin
  inherited;
  self.WindowState := wsMinimized;
end;

procedure TfrmPosMain.BarcodeFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if length(fndStr)=6 then
     Accept := copy(DataSet.FieldbyName('BARCODE').AsString,length(DataSet.FieldbyName('BARCODE').AsString)-5,6)=fndStr
  else
     Accept := DataSet.FieldbyName('BARCODE').AsString=fndStr;

end;

procedure TfrmPosMain.GodsInfoFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept :=
    (pos(fndStr,DataSet.FieldbyName('GODS_CODE').AsString)>0)

end;

procedure TfrmPosMain.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if cdsTable.FieldbyName('IS_PRESENT').AsInteger<>0 then
     AFont.Color := clRed;

end;

procedure TfrmPosMain.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) then
  begin
    DBGridEh2.Canvas.Brush.Color := clNavy;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmPosMain.Label27Click(Sender: TObject);
begin
  inherited;
  PopupMenu;
  Exit;
end;

procedure TfrmPosMain.h6Click(Sender: TObject);
begin
  inherited;
  InputFlag := 1;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.Label21Click(Sender: TObject);
begin
  inherited;
  if (dbState = dsBrowse) then Exit;
  PostMessage(Handle,WM_DIALOG_PULL,FIND_GUIDE_DIALOG,1);
end;

procedure TfrmPosMain.h9Click(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then Exit;
  InputFlag := 10;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.h10Click(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then Exit;
  InputFlag := 11;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.Label22Click(Sender: TObject);
begin
  inherited;
  if (dbState = dsBrowse) then Exit;
  ConvertUnit;
end;

procedure TfrmPosMain.h2Click(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,WM_EXEC_ORDER,0,2);
end;

procedure TfrmPosMain.Label20Click(Sender: TObject);
begin
  inherited;
  if (dbState = dsBrowse) then Exit;
  OpenDialogPrice;
end;

procedure TfrmPosMain.Label26Click(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if cdsTable.FieldbyName('GODS_ID').asString='' then Exit;
  InputFlag := 9;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.Label8Click(Sender: TObject);
var AObj_1:TRecord_;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if MessageBox(Handle,'请确认是否删除当前选中的商品?','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  AObj_1 := TRecord_.Create;
  try
    AObj_1.ReadFromDataSet(cdsTable);
    DelRecord(AObj_1);
  finally
    AObj_1.Free;
  end;
end;

procedure TfrmPosMain.Label28Click(Sender: TObject);
begin
  inherited;
  if (dbState = dsBrowse) then Exit;
  ConvertPresent;
end;

procedure TfrmPosMain.Label11Click(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then Exit;
  InputFlag := 2;
  if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
end;

procedure TfrmPosMain.h5Click(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if cdsTable.IsEmpty then Exit;
  if cdsTable.FieldByName('GODS_ID').AsString = '' then Exit;
  ReturnGods;
end;

procedure TfrmPosMain.h12Click(Sender: TObject);
begin
  inherited;
  if InputFlag<>0 then
    begin
      edtInput.Text := '';
      DBGridEh1.Col := 1;
      InputFlag := 0;
    end;
end;

procedure TfrmPosMain.Label25Click(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,WM_EXEC_ORDER,0,3);
end;

procedure TfrmPosMain.Label10Click(Sender: TObject);
begin
  inherited;
  frmMain.FindAction('actfrmLockScreen').OnExecute(nil);
end;

procedure TfrmPosMain.h11Click(Sender: TObject);
begin
  inherited;
  if cdsTable.IsEmpty then exit;
  PostMessage(Handle,WM_EXEC_ORDER,0,0);
end;

procedure TfrmPosMain.Label23Click(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,WM_EXEC_ORDER,0,5);
end;

procedure TfrmPosMain.Label24Click(Sender: TObject);
begin
  inherited;
  PostMessage(Handle,WM_EXEC_ORDER,0,6);
end;

procedure TfrmPosMain.Label9Click(Sender: TObject);
begin
  inherited;
  DevFactory.OpenCashBox;
end;

procedure TfrmPosMain.CancelCardExecute;
var CardNo,CardName:String;
begin
  inherited;
  if TfrmCancelCard.SelectCard(Self,AObj.FieldbyName('CLIENT_ID').AsString,'#',CardNo,CardName) then
    begin
      MessageBox(Handle,pchar(CardName+'卡"'+CardNo+'"注销成功！'),pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmPosMain.DepositExecute;
var BALANCE:string;
begin
  inherited;
  if TfrmDeposit.Open(AObj.FieldbyName('CLIENT_ID').AsString,BALANCE) then
     begin
       AObj.FieldbyName('BALANCE').AsFloat := StrtoFloatDef(BALANCE,0);
       fndBALANCE.Text := AObj.FieldbyName('BALANCE').asString;
     end;

end;

procedure TfrmPosMain.LossCardExecute;
var CardNo,CardName:String;
begin
  inherited;
  if TfrmLossCard.SelectCard(Self,AObj.FieldbyName('CLIENT_ID').AsString,'#',CardNo,CardName) then
    begin
      MessageBox(Handle,pchar(CardName+'卡"'+CardNo+'"挂失成功！'),pchar(Application.Title),MB_OK);
    end;
end;

procedure TfrmPosMain.NewCardExecute;
 procedure UpdateToGlobal(IC:string;ID:string);
   var Temp:TZQuery;
   begin
      Temp := Global.GetZQueryFromName('PUB_CUSTOMER');
      Temp.Filtered := false;
      if not Temp.Locate('CLIENT_ID',ID,[]) then
         Temp.Append
      else
         Temp.Edit;
      Temp.FieldByName('IC_CARDNO').AsString:=IC;
      Temp.Post;
   end;
var card,Union,ClientId:string;
begin
  inherited;
  ClientId := AObj.FieldbyName('CLIENT_ID').AsString;
  if TfrmNewCard.SelectSendCard(Self,ClientId,'#',AObj.FieldbyName('CLIENT_ID_TEXT').AsString,1,card,Union) then
    begin
      if Union = '#' then
        begin
          UpdateToGlobal(card,AObj.FieldbyName('CLIENT_ID').AsString);
          MessageBox(Handle,'发新卡成功！',pchar(Application.Title),MB_OK);
        end
      else
        begin
          MessageBox(Handle,'发新卡成功！',pchar(Application.Title),MB_OK);
          if not ShopGlobal.GetChkRight('33400001',3) then Exit;// 属自动弹出功能，没有就不弹出，不用提醒 Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
          with TfrmCustomerInfo.Create(self) do
              begin
                try
                  Edit(ClientId);
                  ShowModal;
                finally
                  free;
                end;
              end;
        end;
    end;
end;

procedure TfrmPosMain.PasswordExecute;
begin
  TfrmPassWord.SelectCard(Self,AObj.FieldbyName('CLIENT_ID').AsString,IntToStr(Global.TENANT_ID));
end;

procedure TfrmPosMain.ReturnExecute;
var BALANCE:String;
begin
  inherited;
  if TfrmReturn.Open(AObj.FieldbyName('CLIENT_ID').AsString,BALANCE) then
     begin
       AObj.FieldbyName('BALANCE').AsFloat := StrtoFloatDef(BALANCE,0);
       fndBALANCE.Text := AObj.FieldbyName('BALANCE').asString;
     end;
end;

procedure TfrmPosMain.Setxsm(const Value: boolean);
begin
  Fxsm := Value;
end;

function TfrmPosMain.CheckNotChangePrice(GodsID: string): Boolean;
var
  RelationID: string;
  RsGods,Rs: TZQuery;
begin
  result:=False;
  RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO');
  if RsGods.Locate('GODS_ID',trim(GodsID),[]) then
  begin
    RelationID:=trim(RsGods.fieldbyName('RELATION_ID').AsString);
  end;
  Rs:=Global.GetZQueryFromName('CA_RELATIONS');
  if Rs.Locate('RELATION_ID',RelationID,[]) then
  begin
    result:=(trim(Rs.FieldByName('CHANGE_PRICE').AsString)='2');
  end;

end;

function TfrmPosMain.CheckSale_Limit: Boolean;
var
  CurIdx: integer;
  GodsID, RelationID: string;  
  Singe_Litmit,All_Litmit: Real;  //单品限量，本单限量
  RsGods,RsRelation,GodsQry,RelQry: TZQuery;
begin
  result:=False;
  try
    GodsQry:=TZQuery.Create(nil);  //本单商品汇总
    GodsQry.Close;
    GodsQry.FieldDefs.Add('GODS_ID',ftstring,36,true);
    GodsQry.FieldDefs.Add('GODS_NAME',ftstring,50,true);
    GodsQry.FieldDefs.Add('CalcSum',ftFloat,0,true);
    GodsQry.CreateDataSet;  
    RelQry:=TZQuery.Create(nil);   //本单供应链汇总
    RelQry.Close;
    RelQry.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
    RelQry.FieldDefs.Add('RELATION_NAME',ftstring,50,true);
    RelQry.FieldDefs.Add('CalcSum',ftFloat,0,true);
    RelQry.CreateDataSet;
    RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO'); //商品档案
    RsRelation:=Global.GetZQueryFromName('CA_RELATIONS'); //供应链
    //开始循环[累计出本单单品和供应链汇总数据]：
    CurIdx:=cdsTable.RecNo;  //保存当前序号
    cdsTable.First;
    while not cdsTable.Eof do
    begin
      GodsID:=trim(cdsTable.fieldbyName('GODS_ID').AsString);
      //单项目累计
      if GodsQry.Locate('GODS_ID',GodsID,[]) then //定位则累计数量
      begin
        GodsQry.Edit;
        GodsQry.FieldByName('CalcSum').AsFloat:=GodsQry.FieldByName('CalcSum').AsFloat+cdsTable.fieldbyName('CALC_AMOUNT').AsFloat;
        GodsQry.Post;
      end else
      begin
        GodsQry.Append;
        GodsQry.FieldByName('GODS_ID').AsString:=GodsID;
        GodsQry.FieldByName('GODS_NAME').AsString:=trim(cdsTable.fieldbyName('GODS_NAME').AsString);
        GodsQry.FieldByName('CalcSum').AsFloat:=cdsTable.fieldbyName('CALC_AMOUNT').AsFloat;
        GodsQry.Post;
      end;
      if RsGods.Locate('GODS_ID',GodsID,[]) then
      begin
        RelationID:=trim(RsGods.fieldbyName('RELATION_ID').AsString);
        //单项目累计
        if RelQry.Locate('RELATION_ID',RelationID,[]) then //定位则累计数量
        begin
          RelQry.Edit;
          RelQry.FieldByName('CalcSum').AsFloat:=RelQry.FieldByName('CalcSum').AsFloat+cdsTable.fieldbyName('CALC_AMOUNT').AsFloat;
          RelQry.Post;
        end else
        begin  
          RelQry.Append;
          RelQry.FieldByName('RELATION_ID').AsString:=RelationID;
          if RsRelation.Locate('RELATION_ID',RelationID,[]) then 
            RelQry.FieldByName('RELATION_NAME').AsString:=trim(RsRelation.fieldbyName('RELATION_NAME').AsString);
          RelQry.FieldByName('CalcSum').AsFloat:=cdsTable.fieldbyName('CALC_AMOUNT').AsFloat;
          RelQry.Post;
        end;
      end; 
      cdsTable.Next;
    end;

    //判断单品是否超过
    GodsQry.First;
    while not GodsQry.Eof do
    begin
      GodsID:=trim(GodsQry.fieldbyName('GODS_ID').AsString);
      if RsGods.Locate('GODS_ID',GodsID,[]) then
      begin
        RelationID:=trim(RsGods.fieldbyName('RELATION_ID').AsString);
        if RsRelation.Locate('RELATION_ID',RelationID,[]) then
        begin
          Singe_Litmit:=RsRelation.FieldByName('SINGLE_LIMIT').AsFloat; //单品限量
          if (Singe_Litmit>0) and (GodsQry.FieldByName('CalcSum').AsFloat>Singe_Litmit) then
            Raise Exception.Create('商品〖'+GodsQry.fieldbyName('GODS_NAME').AsString+'〗数量'+FloattoStr(GodsQry.FieldByName('CalcSum').AsFloat)+'超过限量值'+FloattoStr(Singe_Litmit)+'！');
        end;
      end;
      GodsQry.Next;
    end;

    //判断供应链本单限量：
    RelQry.First;
    while not RelQry.Eof do
    begin
      RelationID:=trim(RelQry.fieldbyName('RELATION_ID').AsString);
      if RsRelation.Locate('RELATION_ID',RelationID,[]) then
      begin
        All_Litmit:=RsRelation.FieldByName('SALE_LIMIT').AsFloat; //本单限量
        if (All_Litmit>0) and (RelQry.FieldByName('CalcSum').AsFloat>All_Litmit) then
          Raise Exception.Create('供应链〖'+RelQry.FieldByName('RELATION_NAME').AsString+'〗本单总量'+FloattoStr(RelQry.FieldByName('CalcSum').AsFloat)+' 超过限量值'+FloattoStr(All_Litmit)+'！');
      end;
      RelQry.Next;
    end;
  finally
    cdsTable.RecNo:=CurIdx;   
    GodsQry.Free;
    RelQry.Free;
  end;
end;

procedure TfrmPosMain.OpenDialogTrend;
var
  SObj:TRecord_;
  SQL:string;
begin
  if dbState = dsBrowse then Exit;
  if cdsTable.FieldbyName('GODS_ID').AsString = '' then Exit;
  SObj := TRecord_.Create;
  try
    SQL := 'select CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO from PUB_CODE_INFO where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CODE_TYPE=''17'' and COMM not in (''02'',''12'')';
    if TframeListDialog.FindDialog(self,SQL,'CODE_NAME=名称,CODE_SPELL=拼音码,SEQ_NO=序号',SObj) then
       begin
         cdsTable.Edit;
         cdsTable.FieldByName('TREND_ID').AsString := SObj.FieldbyName('CODE_ID').AsString;
         cdsTable.Post;
       end;
  finally
    SObj.Free;
  end;
end;

procedure TfrmPosMain.Label3Click(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then Exit;
  OpenDialogTrend;
end;

procedure TfrmPosMain.edtInputEnter(Sender: TObject);
begin
  inherited;
  if myHKL>0 then
  ActivateKeyBoardLayOut(myHKL,KLF_ACTIVATE);
end;

procedure TfrmPosMain.SetIsReck(const Value: boolean);
begin
  FIsReck := Value;
end;

procedure TfrmPosMain.LoadFromFile;
var
  sm:TMemoryStream;
begin
  if not FileExists(ExtractFilePath(ParamStr(0))+'temp\pos.dat') then Exit;
  if MessageBox(Handle,'系统检测存在没有保存的异常数据，是否恢复?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
     begin
        sm := TMemoryStream.Create;
        try
          sm.LoadFromFile(ExtractFilePath(ParamStr(0))+'temp\pos.dat');
          cdsTable.LoadFromStream(sm);
          cdsTable.Last;
          RowId := cdsTable.FieldbyName('SEQNO').AsInteger;
          Calc;
        finally
          sm.Free;
        end;
     end;
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\pos.dat');
end;

procedure TfrmPosMain.SaveToFile;
var
  sm:TMemoryStream;
  code:integer;
begin
  if cdsTable.IsEmpty then
     begin
       DeleteFile(ExtractFilePath(ParamStr(0))+'temp\pos.dat');
       Exit;
     end;
  code := 0;
  try
    sm := TMemoryStream.Create;
    try
      inc(code);
      cdsTable.SaveToStream(sm);
      sm.Position := 0;
      inc(code);
      sm.SaveToFile(ExtractFilePath(ParamStr(0))+'temp\pos.dat');
    finally
      sm.Free;
    end;
  except
    on E:Exception do
       LogFile.AddLogFile(0,'PosMain.SaveToFile error<'+inttostr(code)+'>:'+E.Message); 
  end;
end;

procedure TfrmPosMain.LookOrder;
var SalesId:String;
begin
  if dbState in [dsInsert,dsEdit] then
    if not cdsTable.IsEmpty then Raise Exception.Create('在开单状态下,不能进行销售单查询!');
  SalesId := TfrmPosMainList.FindDialog(Self);
  if SalesId = '' then Exit;
  Open(SalesId);
end;

procedure TfrmPosMain.DoPrintOrder(id: string);
begin
  with TfrmFastReport.Create(Self) do
    begin
      try
        PrintReport(PrintSQL(inttostr(Global.TENANT_ID),id),frfSalesOrder,false);
      finally
        free;
      end;
    end;
end;

procedure TfrmPosMain.frfSalesOrderUserFunction(const Name: String; p1, p2,
  p3: Variant; var Val: Variant);
var small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
     begin
       small := frParser.Calc(p1);
       Val := FnNumber.SmallTOBig(small);
     end;
end;

procedure TfrmPosMain.frfSalesOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := ShopGlobal.TENANT_NAME;
  if ParName='企业简称' then ParValue := ShopGlobal.SHORT_TENANT_NAME;

end;

procedure TfrmPosMain.SetbasInfo(const Value: TZQuery);
begin
  FbasInfo := Value;
  dsGodsInfo.DataSet := Value;
end;

function TfrmPosMain.GetbasInfo: TZQuery;
begin
  result := FBasInfo;
  if not FBasInfo.Active then BasInfo := Global.GetZQueryFromName('PUB_GOODSINFO');  
end;

end.
